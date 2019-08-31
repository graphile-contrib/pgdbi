const NO_INDEX = 'NO_INDEX'
const MULTIPLE_INDICES = 'MULTIPLE_INDICES'

function evaluateGenericIndexEvaluations(state) {
  const evaluations = state.managedSchemata
    .reduce(
      (all, schema) => {
        return {
          ...all
          ,...schema.schemaTables.reduce(
            (all, table) => {
              const genericIndexEvaluations = table.indices.reduce(
                (all, idx) => {
                  const idxColumns = idx.indexColumns.map(c => c.columnName).sort((a,b)=>{return a<b?-1:1}).join('+')
                  const idxKey = `${idx.tableSchema}.${idx.tableName}.${idxColumns}`
                  const existing = all[idxKey]
                  const idxEvaluation = existing ? 
                    {
                      ...existing,
                      evaluation: MULTIPLE_INDICES,
                      indexDisplayClass: 'red--text',
                      indices: [...existing.indices, idx]
                    } :
                    {
                      id: idxKey,
                      idxKey: idxKey,
                      idxColumns: idxColumns,
                      tableKey: `${idx.tableSchema}.${idx.tableName}`,
                      indexDisplayClass: 'green--text',
                      evaluation: idxColumns,
                      indices: [idx]
                    }

                  return {
                    ...all,
                    [idxKey]: idxEvaluation
                  }
                }, {}
              )
    
              return {
                ...all
                ,...genericIndexEvaluations
              }
            }, {}
          )
        }
      }, {}
    )

  state.genericIndexEvaluations = evaluations
}

export default evaluateGenericIndexEvaluations