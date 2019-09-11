import Mustache from 'mustache'

const NO_INDEX = 'NO_INDEX'
const MULTIPLE_INDICES = 'MULTIPLE_INDICES'

function formatScript (scriptText) {
  return (scriptText || '')
    .toLowerCase()
    .split(' exists').join(' exists\n    ')
    .split(' on').join('\n  on\n    ')
    .split(' using').join('\n  using')
    .split(' (').join(' (\n    ')
    .split(', ').join(',\n    ')
    .split(');').join('\n);')
}

const createIndexTemplate = `create index if not exists 
    {{indexName}}
  on 
    {{tableSchema}}.{{tableName}}
  using btree(
    {{indexColumns}}
  );`

function evaluateSingleColumnForeignKeys(state){
  const evaluations = state.managedSchemata
    .reduce(
      (all, schema) => {
        return {
          ...all
          ,...schema.schemaTables.reduce(
            (all, table) => {
              const fkColumnEvaluations = (table.tableColumns || [])
              .reduce(
                (all, c) => {
                  // foreign keys
                  const fkConstraintUsage = (table.referentialConstraints || [])
                    .filter(rc => rc.referencingColumnUsage.length === 1)
                    .filter(
                      rc => {
                        return rc.referencingColumnUsage.find(rcu => rcu.tableSchema === c.tableSchema && rcu.tableName === c.tableName && rcu.columnName === c.columnName) !== undefined
                      }
                    )
                    .map(
                      rc => {
                        const fkIndices = table.indices
                          .filter(
                            i => {
                              return i.tableSchema === c.tableSchema && 
                              i.tableName === c.tableName &&
                              i.indexColumns.length === 1 &&
                              i.indexColumns[0].columnName === c.columnName
                            }
                          )

                        const fkIndexEvaluation = fkIndices.length == 0 ? NO_INDEX : (fkIndices.length > 1 ? MULTIPLE_INDICES : fkIndices[0].indexName)
                        const indexDisplayClass = fkIndexEvaluation === NO_INDEX || fkIndexEvaluation === MULTIPLE_INDICES ? 'red--text' : 'green--text'
                        const defaultIndexName = `${c.tableSchema}_${c.tableName}_${c.columnName}`
                        const defaultRealization = {
                          create: `---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: ${rc.constraintName}\n  ${ Mustache.render(createIndexTemplate, {
                              indexName: `idx_${defaultIndexName}`,
                            tableSchema: c.tableSchema,
                            tableName: c.tableName,
                            indexColumns: c.columnName,
                          })}\n-----------------------------\n`
                        }

                        const currentRealization = fkIndices.reduce(
                          (all, idx) => {
                            const isIgnored = Object.keys(state.indicesToDrop).indexOf(idx.id) > -1
                            if (isIgnored) {
                              return {
                                ...all,  
                                drop: (all.drop || '').concat(`${idx.indexDrop}`)
                              }  
                            } else {
                              const createScript = `---- EXISTING SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: ${rc.constraintName}\n  ${formatScript(idx.indexDefinition)}\n-----------------------------\n`

                              return {
                                ...all,  
                                create: (all.create || '').concat(`${createScript}`)
                              }  
                            }
                          }, {}
                        )
                        const desiredRealization = currentRealization.drop === undefined && currentRealization.create === undefined ? defaultRealization : currentRealization

                        const rcu = rc.referencedColumnUsage[0]
                        return {
                          id: rc.constraintName,
                          constraintName: rc.constraintName,
                          tableSchema: table.tableSchema,
                          tableName: table.tableName,
                          fkTable: `${rcu.tableSchema}.${rcu.tableName}`,
                          fkSource: [c.columnName],
                          fkTarget: [`${rcu.columnName}`],
                          fkIndices: fkIndices,
                          fkIndexEvaluation: fkIndexEvaluation,
                          fkTableLinkId: `${rcu.tableSchema}.${rcu.tableName}`,
                          evaluation: fkIndexEvaluation,
                          idxColumns: [c.columnName],
                          indices: fkIndices,
                          indexDisplayClass: indexDisplayClass,
                          desiredRealization: desiredRealization
                        }
                      }
                    )
      
                  if (fkConstraintUsage.length > 0) {
                    return {
                      ...all
                      ,[c.id]: fkConstraintUsage
                    }  
                  } else {
                    return all
                  }
                }, {}
              )
    
              return {
                ...all
                ,...fkColumnEvaluations
              }
            }, {}
          )
        }
      }, {}
    )

    state.fkIndexEvaluations = {
      ...state.fkIndexEvaluations,
      singleColumn: evaluations
    }
}

function evaluateMultiColumnForeignKeys(state){
  const evaluations = state.managedSchemata
    .reduce(
      (all, schema) => {
        return {
          ...all
          ,...schema.schemaTables.reduce(
            (all, table) => {
              const fkIndexEvaluations = (table.referentialConstraints || [])
              .filter(rc => rc.referencingColumnUsage.length > 1)
              .map(
                rc => {
                  const fkSource = rc.referencingColumnUsage
                    // .sort((a,b)=>{return a.columnName < b.columnName ? -1 : 1})
                    .map(rcu => rcu.columnName)
                    .join(', ')

                  const defaultIndexName = fkSource.split(', ').join('_')

                  const fkTarget = rc.referencedColumnUsage
                    // .sort((a,b)=>{return a.columnName < b.columnName ? -1 : 1})
                    .map(rcu => rcu.columnName)
                    .join(', ')

                  const fkIndices = table.indices
                    .filter(i => i.indexColumns.length === rc.referencingColumnUsage.length)
                    .filter(
                      i => {
                        const indexCols = i.indkey.map(ik => i.indexColumns.find(ic => ic.indkey === ik).columnName).join(', ')
                        return indexCols === fkSource                   
                      }
                    )
                  
                  const fkIndexEvaluation = fkIndices.length == 0 ? NO_INDEX : (fkIndices.length > 1 ? MULTIPLE_INDICES : fkIndices[0].indexName)                        
                  const indexDisplayClass = fkIndexEvaluation === NO_INDEX || fkIndexEvaluation === MULTIPLE_INDICES ? 'red--text' : 'green--text'
                  const defaultRealization = {
                    // create: `create index if not exists idx_${table.tableSchema}_${table.tableName}_${defaultIndexName} on ${table.tableSchema}_${table.tableName} using btree(${fkSource});`
                    create: `---- NEW MULTI-COLUMN FK-INDEX FOR CONSTRAINT: ${rc.constraintName}\n  ${ Mustache.render(createIndexTemplate, {
                      indexName: `idx_${defaultIndexName}`,
                        tableSchema: table.tableSchema,
                        tableName: table.tableName,
                        indexColumns: fkSource.split(', ').join(',\n    '),
                    })}\n-----------------------------\n`
                  }

                  const currentRealization = fkIndices.reduce(
                    (all, idx) => {
                      const isIgnored = Object.keys(state.indicesToDrop).indexOf(idx.id) > -1
                      if (isIgnored) {
                        return {
                          ...all,  
                          drop: (all.drop || '').concat(`${idx.indexDrop}`)
                        }  
                      } else {
                        const createScript = `---- EXISTING MULTI-COLUMN FK-INDEX FOR CONSTRAINT: ${rc.constraintName}\n  ${formatScript(idx.indexDefinition)}\n-----------------------------\n`
                        return {
                          ...all,  
                          create: (all.create || '').concat(`${createScript}`)
                        }  
                      }
                    }, {}
                  )
                  const desiredRealization = currentRealization.drop === undefined && currentRealization.create === undefined ? defaultRealization : currentRealization

                  const rcu = rc.referencedColumnUsage[0]
                  return {
                    id: rc.constraintName,
                    constraintName: rc.constraintName,
                    tableSchema: table.tableSchema,
                    tableName: table.tableName,
                    fkTable: `${rcu.tableSchema}.${rcu.tableName}`,
                    fkSource: fkSource.split(', '),
                    fkTarget: fkTarget.split(', '),
                    fkIndices: fkIndices,
                    fkIndexEvaluation: fkIndexEvaluation,
                    fkTableLinkId: `${rcu.tableSchema}.${rcu.tableName}`,
                    evaluation: fkIndexEvaluation,
                    idxColumns: fkSource.split(', '),
                    indices: fkIndices,
                    indexDisplayClass: indexDisplayClass,
                    desiredRealization: desiredRealization
                  }
                }
              )

              return {
                ...all
                ,[table.id]: fkIndexEvaluations
              }
            }, {}
          )
        }
      }, {}
    )

    state.fkIndexEvaluations = {
      ...state.fkIndexEvaluations,
      multiColumn: evaluations
    }
}

function evaluateFkIndexes(state) {
  evaluateSingleColumnForeignKeys(state)
  evaluateMultiColumnForeignKeys(state)

}

export default evaluateFkIndexes