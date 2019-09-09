const NO_INDEX = 'NO_INDEX'
const MULTIPLE_INDICES = 'MULTIPLE_INDICES'

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
                        const uqIndices = table.indices
                          .filter(i => i.indexColumns.length === 1)
                          .filter(i => i.indexColumns[0].columnName === c.columnName)

                        const kcu = uc.keyColumnUsage[0]
                        const uqSource = uc.keyColumnUsage[0].columnName

                        const uqIndexEvaluation = uqIndices.length == 0 ? NO_INDEX : (uqIndices.length > 1 ? MULTIPLE_INDICES : uqIndices[0].indexName)
                        const indexDisplayClass = uqIndexEvaluation === NO_INDEX || uqIndexEvaluation === MULTIPLE_INDICES ? 'red--text' : 'green--text'
                        const defaultIndexName = `${kcu.tableSchema}.${kcu.tableName}.${kcu.columnName}`
                        const defaultRealization = {
                          create: `create index if not exists idx_${defaultIndexName} on ${c.tableSchema}.${c.tableName} using btree(${c.columnName});`
                        }
                        const currentRealization = uqIndices.reduce(
                          (all, idx) => {
                            const isIgnored = Object.keys(state.indicesToDrop).indexOf(idx.id) > -1
                            if (isIgnored) {
                              return {
                                ...all,  
                                drop: (all.drop || '').concat(`${idx.indexDrop}\n\n`)
                              }  
                            } else {
                              return {
                                ...all,  
                                create: (all.create || '').concat(`${idx.indexDefinition}\n\n`)
                              }  
                            }
                          }, {}
                        )
                        const desiredRealization = currentRealization.drop === undefined && currentRealization.create === undefined ? defaultRealization : currentRealization

                        return {
                          id: uc.constraintName,
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

                  const defaultIndexName = uqSource.split(', ').join('_')

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
                    create: `create index if not exists idx_${table.tableSchema}_${table.tableName}_${defaultIndexName} on ${table.tableSchema}_${table.tableName} using btree(${uqSource});`
                  }
                  const currentRealization = uqIndices.reduce(
                    (all, idx) => {
                      const isIgnored = Object.keys(state.indicesToDrop).indexOf(idx.id) > -1
                      if (isIgnored) {
                        return {
                          ...all,  
                          drop: (all.drop || '').concat(`${idx.indexDrop}\n\n`)
                        }  
                      } else {
                        return {
                          ...all,  
                          create: (all.create || '').concat(`${idx.indexDefinition}\n\n`)
                        }  
                      }
                    }, {}
                  )
                  const desiredRealization = currentRealization.drop === undefined && currentRealization.create === undefined ? defaultRealization : currentRealization

                  return {
                    id: uc.constraintName,
                    constraintName: uc.constraintName,
                    tableSchema: table.tableSchema,
                    tableName: table.tableName,
                    uqPath: `${kcu.tableSchema}.${kcu.tableName}.${kcu.columnName}`,
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
}

function evaluateUqIndexes(state){
  evaluateSingleColumnUqIndexes(state)
  evaluateMultiColumnUqIndexes(state)
}

export default evaluateUqIndexes