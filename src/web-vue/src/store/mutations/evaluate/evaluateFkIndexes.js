const NO_INDEX = 'NO_INDEX'
const MULTIPLE_INDICES = 'MULTIPLE_INDICES'

function evaluateFkIndexes(state) {
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
                  const columnIndices = table.indices.filter(i => i.tableSchema === c.tableSchema && i.tableName === c.tableName && i.columnName === c.columnName)

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
                        const fkIndexEvaluation = columnIndices.length == 0 ? NO_INDEX : (columnIndices.length > 1 ? MULTIPLE_INDICES : columnIndices[0].indexName)
                        const rcu = rc.referencedColumnUsage[0]
                        return {
                          constraintName: rc.constraintName,
                          fkPath: `${rcu.tableSchema}.${rcu.tableName}.${rcu.columnName}`,
                          fkIndices: columnIndices,
                          fkIndexEvaluation: fkIndexEvaluation,
                          fkTableLinkId: `${rcu.tableSchema}.${rcu.tableName}`
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

  state.fkIndex = {
    ...state.fkIndex
    ,evaluations: evaluations
  }
}

export default evaluateFkIndexes