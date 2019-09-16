import Mustache from 'mustache'
import storeEvaluations from './storeEvaluations'
import evaluateEnumScripts from './evaluateEnumScripts'

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

function evaluateSingleColumnUqIndexes(state) {
  const evaluations = state.managedSchemata
    .reduce(
      (all, schema) => {
        return {
          ...all
          ,...schema.schemaTables.reduce(
            (all, table) => {
              const uqColumnEvaluations = (table.tableColumns || [])
              .reduce(
                (all, c) => {
                  // foreign keys
                  const uqConstraintUsage = (table.uniqueConstraints || [])
                  .filter(rc => rc.keyColumnUsage.length === 1)
                  .filter(
                      rc => {
                        return rc.keyColumnUsage.find(kcu => kcu.tableSchema === c.tableSchema && kcu.tableName === c.tableName && kcu.columnName === c.columnName) !== undefined
                      }
                    )
                    .map(
                      uc => {
                        // const idxColumns = idx.indkey.map(ik => idx.indexColumns.find(ic => ic.indkey === ik).columnName).join(', ')
                        // const idxKey = `${table.tableSchema}.${table.tableName}.${}`

                        const uqIndices = table.indices
                          .filter(i => i.indexColumns.length === 1)
                          .filter(i => i.indexColumns[0].columnName === c.columnName)

                        const kcu = uc.keyColumnUsage[0]
                        const uqSource = uc.keyColumnUsage[0].columnName

                        const uqIndexEvaluation = uqIndices.length == 0 ? NO_INDEX : (uqIndices.length > 1 ? MULTIPLE_INDICES : uqIndices[0].indexName)
                        const indexDisplayClass = uqIndexEvaluation === NO_INDEX || uqIndexEvaluation === MULTIPLE_INDICES ? 'red--text' : 'green--text'
                        const defaultIndexName = `${kcu.tableSchema}_${kcu.tableName}_${kcu.columnName}`
                        const defaultRealization = {
                          create: `---- NEW SINGLE-COLUMN UNIQUE-INDEX FOR CONSTRAINT: ${kcu.constraintName}\n  ${ Mustache.render(createIndexTemplate, {
                            indexName: `idx_${defaultIndexName}`,
                            tableSchema: c.tableSchema,
                            tableName: c.tableName,
                            indexColumns: c.columnName,
                          })}\n-----------------------------\n`
                          // create: `create index if not exists idx_${defaultIndexName} on ${c.tableSchema}.${c.tableName} using btree(${c.columnName});`
                        }
                        const currentRealization = uqIndices.reduce(
                          (all, idx) => {
                            const isIgnored = Object.keys(state.indicesToDrop).indexOf(idx.id) > -1
                            if (isIgnored) {
                              return {
                                ...all,  
                                drop: (all.drop || '').concat(`${idx.indexDrop}`)
                              }  
                            } else {
                              const createScript = `---- EXISTING SINGLE-COLUMN UNIQUE-INDEX FOR CONSTRAINT: ${kcu.constraintName}\n  ${formatScript(idx.indexDefinition)}\n-----------------------------\n`
                              return {
                                ...all,  
                                create: (all.create || '').concat(`${createScript}`)
                              }  
                            }
                          }, {}
                        )
                        const desiredRealization = currentRealization.drop === undefined && currentRealization.create === undefined ? defaultRealization : currentRealization

                        return {
                          id: uc.constraintName,
                          idxKey: defaultIndexName,
                          idxType: 'unique',
                          constraintName: uc.constraintName,
                          tableSchema: table.tableSchema,
                          tableName: table.tableName,
                          uqSource: uqSource,
                          uqPath: defaultIndexName,
                          uqTableId: `${kcu.tableSchema}.${kcu.tableName}`,
                          uqIndices: uqIndices,
                          uqIndexEvaluation: uqIndexEvaluation,
                          evaluation: uqIndexEvaluation,
                          idxColumns: [c.columnName],
                          indices: uqIndices,
                          indexDisplayClass: indexDisplayClass,
                          desiredRealization: desiredRealization
                        }
                      }
                    )
      
                  if (uqConstraintUsage.length > 0) {
                    return {
                      ...all
                      ,[c.id]: uqConstraintUsage
                    }  
                  } else {
                    return all
                  }
                }, {}
              )
    
              return {
                ...all
                ,...uqColumnEvaluations
              }
            }, {}
          )
        }
      }, {}
    )

  state.uqIndexEvaluations = {
    ...state.uqIndexEvaluations,
    singleColumn: evaluations
  }

  storeEvaluations(state, evaluations)
}

function evaluateMultiColumnUqIndexes(state) {
  const evaluations = state.managedSchemata
    .reduce(
      (all, schema) => {
        return {
          ...all
          ,...schema.schemaTables.reduce(
            (all, table) => {
              const uqIndexEvaluations = (table.uniqueConstraints || [])
              .filter(uc => uc.keyColumnUsage.length > 1)
              .map(
                uc => {
                  const uqSource = uc.keyColumnUsage
                    .sort((a,b)=>{return a.columnName < b.columnName ? -1 : 1})
                    .map(kcu => kcu.columnName)
                    .join(', ')

                  const defaultIndexName = `${table.tableSchema}_${table.tableName}_${uqSource.split(', ').join('_')}`

                  const uqIndices = table.indices
                    .filter(i => i.indexColumns.length === uc.keyColumnUsage.length)
                    .filter(
                      i => {
                        const indexCols = i.indkey.map(ik => i.indexColumns.find(ic => ic.indkey === ik).columnName).join(', ')
                        return indexCols === uqSource                   
                      }
                    )
                  
                  const uqIndexEvaluation = uqIndices.length == 0 ? NO_INDEX : (uqIndices.length > 1 ? MULTIPLE_INDICES : uqIndices[0].indexName)                        
                  const indexDisplayClass = uqIndexEvaluation === NO_INDEX || uqIndexEvaluation === MULTIPLE_INDICES ? 'red--text' : 'green--text'
                  const kcu = uc.keyColumnUsage[0]
                  const defaultRealization = {
                    // create: `create index if not exists idx_${table.tableSchema}_${table.tableName}_${defaultIndexName} on ${table.tableSchema}_${table.tableName} using btree(${uqSource});`
                    create: `---- NEW MULTI-COLUMN UNIQUE-INDEX FOR CONSTRAINT: ${kcu.constraintName}\n  ${ Mustache.render(createIndexTemplate, {
                      indexName: `idx_${defaultIndexName}`,
                        tableSchema: table.tableSchema,
                        tableName: table.tableName,
                        indexColumns: uqSource.split(', ').join(',\n    '),
                    })}\n-----------------------------\n`
                  }
                  const currentRealization = uqIndices.reduce(
                    (all, idx) => {
                      const isIgnored = Object.keys(state.indicesToDrop).indexOf(idx.id) > -1
                      if (isIgnored) {
                        return {
                          ...all,  
                          drop: (all.drop || '').concat(`${idx.indexDrop}`)
                        }  
                      } else {
                        const createScript = `---- EXISTING MULTI-COLUMN UNIQUE-INDEX FOR CONSTRAINT: ${kcu.constraintName}\n  ${formatScript(idx.indexDefinition)}\n-----------------------------\n`
                        return {
                          ...all,  
                          create: (all.create || '').concat(`${createScript}`)
                        }  
                      }
                    }, {}
                  )
                  const desiredRealization = currentRealization.drop === undefined && currentRealization.create === undefined ? defaultRealization : currentRealization

                  return {
                    id: uc.constraintName,
                    idxKey: defaultIndexName,
                    idxType: 'unique',
                    constraintName: uc.constraintName,
                    tableSchema: table.tableSchema,
                    tableName: table.tableName,
                    uqPath: `${kcu.tableSchema}_${kcu.tableName}_${kcu.columnName}`,
                    uqTableId: `${kcu.tableSchema}.${kcu.tableName}`,
                    uqSource: uqSource,
                    uqIndices: uqIndices,
                    uqIndexEvaluation: uqIndexEvaluation,
                    evaluation: uqIndexEvaluation,
                    idxColumns: uqSource.split(', '),
                    indices: uqIndices,
                    indexDisplayClass: indexDisplayClass,
                    desiredRealization
                  }
                }
              )


              return {
                ...all
                ,[table.id]: uqIndexEvaluations
              }
            }, {}
          )
        }
      }, {}
    )

  state.uqIndexEvaluations = {
    ...state.uqIndexEvaluations,
    multiColumn: evaluations
  }

  const xformed = Object.values(evaluations)
    .reduce(
      (all, tableEvaluations) => {
        const keyed = tableEvaluations
        .reduce(
          (all, e) => {
            return {
              ...all
              ,[e.idxKey]: [e]
            }
          }, {}
        )

        return {
          ...all
          ,...keyed
        }

      }, {}
    )
    // console.log('uq', evaluations)
    // console.log('xformed', xformed)
    storeEvaluations(state, xformed)
}

function evaluateUqIndexes(state){
  evaluateSingleColumnUqIndexes(state)
  evaluateMultiColumnUqIndexes(state)
}

export default evaluateUqIndexes