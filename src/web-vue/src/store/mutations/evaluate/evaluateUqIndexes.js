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
                        const columnIndices = table.indices
                          .filter(i => i.indexColumns.length === 1)
                          .filter(i => i.indexColumns[0].columnName === c.columnName)

                        const uqSource = uc.keyColumnUsage[0].columnName

                        const uqIndexEvaluation = columnIndices.length == 0 ? NO_INDEX : (columnIndices.length > 1 ? MULTIPLE_INDICES : columnIndices[0].indexName)
                        const indexDisplayClass = uqIndexEvaluation === NO_INDEX || uqIndexEvaluation === MULTIPLE_INDICES ? 'red--text' : 'green--text'
                        const kcu = uc.keyColumnUsage[0]
                        return {
                          id: uc.constraintName,
                          constraintName: uc.constraintName,
                          uqSource: uqSource,
                          uqPath: `${kcu.tableSchema}.${kcu.tableName}.${kcu.columnName}`,
                          uqIndices: columnIndices,
                          uqIndexEvaluation: uqIndexEvaluation,
                          evaluation: uqIndexEvaluation,
                          idxColumns: [c.columnName],
                          indices: columnIndices,
                          indexDisplayClass: indexDisplayClass
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

                  // console.log('uqSource', uqSource)
                  // const uqTarget = rc.referencedColumnUsage
                  //   .sort((a,b)=>{return a.columnName < b.columnName ? -1 : 1})
                  //   .map(rcu => rcu.columnName)
                  //   .join(', ')

                  const uqIndices = table.indices
                    .filter(i => i.indexColumns.length === uc.keyColumnUsage.length)
                    .filter(
                      i => {
                        const indexCols = i.indkey.map(ik => i.indexColumns.find(ic => ic.indkey === ik).columnName).join(', ')
                        // const indexCols = i.indexColumns
                        //   .map(ic => ic.columnName)
                        //   .sort((a,b)=>{return a<b?-1:1})
                        //   .join(', ')
                        // console.log(i.indexName)
                        // console.log(indexCols)
                        // console.log(uqSource)
                        return indexCols === uqSource                   
                      }
                    )
                  // console.log('wha', JSON.stringify(uqIndices,null,2))
                  
                  const uqIndexEvaluation = uqIndices.length == 0 ? NO_INDEX : (uqIndices.length > 1 ? MULTIPLE_INDICES : uqIndices[0].indexName)                        
                  const indexDisplayClass = uqIndexEvaluation === NO_INDEX || uqIndexEvaluation === MULTIPLE_INDICES ? 'red--text' : 'green--text'
                  const kcu = uc.keyColumnUsage[0]
                  return {
                    id: uc.constraintName,
                    constraintName: uc.constraintName,
                    uqPath: `${kcu.tableSchema}.${kcu.tableName}.${kcu.columnName}`,
                    uqSource: uqSource,
                    uqIndices: uqIndices,
                    uqIndexEvaluation: uqIndexEvaluation,
                    evaluation: uqIndexEvaluation,
                    idxColumns: uqSource.split(', '),
                    indices: uqIndices,
                    indexDisplayClass: indexDisplayClass
                  }
                }
              )


              return {
                ...all
                ,[table.id]: uqIndexEvaluations
              }

              // const uqColumnEvaluations = (table.tableColumns || [])
              // .reduce(
              //   (all, c) => {
              //     const columnIndices = table.indices.filter(i => i.tableSchema === c.tableSchema && i.tableName === c.tableName && i.columnName === c.columnName)
              //     // foreign keys
              //     const uqConstraintUsage = (table.uniqueConstraints || [])
              //     .filter(rc => rc.keyColumnUsage.length === 1)
              //     .filter(
              //         rc => {
              //           return rc.keyColumnUsage.find(kcu => kcu.tableSchema === c.tableSchema && kcu.tableName === c.tableName && kcu.columnName === c.columnName) !== undefined
              //         }
              //       )
              //       .map(
              //         rc => {
              //           const uqIndexEvaluation = columnIndices.length == 0 ? NO_INDEX : (columnIndices.length > 1 ? MULTIPLE_INDICES : columnIndices[0].indexName)
              //           const kcu = rc.keyColumnUsage[0]
              //           return {
              //             constraintName: rc.constraintName,
              //             uqPath: `${kcu.tableSchema}.${kcu.tableName}.${kcu.columnName}`,
              //             uqIndices: columnIndices,
              //             uqIndexEvaluation: uqIndexEvaluation,
              //           }
              //         }
              //       )
      
              //     if (uqConstraintUsage.length > 0) {
              //       return {
              //         ...all
              //         ,[c.id]: uqConstraintUsage
              //       }  
              //     } else {
              //       return all
              //     }
              //   }, {}
              // )
    
              // return {
              //   ...all
              //   ,...uqColumnEvaluations
              // }
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