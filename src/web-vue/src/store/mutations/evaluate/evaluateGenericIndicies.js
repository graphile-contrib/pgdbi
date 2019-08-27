const NO_INDEX = 'NO_INDEX'
const MULTIPLE_INDICES = 'MULTIPLE_INDICES'

function evaluateUqIndexes(state) {
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
                  const columnIndices = table.indices.filter(i => i.tableSchema === c.tableSchema && i.tableName === c.tableName && i.columnName === c.columnName)
                  // foreign keys
                  const uqConstraintUsage = (table.uniqueConstraints || [])
                  .filter(rc => rc.keyColumnUsage.length === 1)
                  .filter(
                      rc => {
                        return rc.keyColumnUsage.find(kcu => kcu.tableSchema === c.tableSchema && kcu.tableName === c.tableName && kcu.columnName === c.columnName) !== undefined
                      }
                    )
                    .map(
                      rc => {
                        const uqIndexEvaluation = columnIndices.length == 0 ? NO_INDEX : (columnIndices.length > 1 ? MULTIPLE_INDICES : columnIndices[0].indexName)
                        const kcu = rc.keyColumnUsage[0]
                        return {
                          constraintName: rc.constraintName,
                          uqPath: `${kcu.tableSchema}.${kcu.tableName}.${kcu.columnName}`,
                          uqIndices: columnIndices,
                          uqIndexEvaluation: uqIndexEvaluation,
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

  state.uqIndex = {
    ...state.uqIndex
    ,evaluations: evaluations
  }
}

export default evaluateUqIndexes