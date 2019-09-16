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
                  const idxColumns = idx.indkey.map(ik => idx.indexColumns.find(ic => ic.indkey === ik).columnName).join(', ')
                  const idxKey = `${idx.tableSchema}_${idx.tableName}_${idxColumns}`
                  const existing = all[idxKey]

                  const isIgnored = Object.keys(state.indicesToDrop).indexOf(idx.id) > -1

                  const currentRealization = isIgnored ? { drop: `---- DROP EXISTING GENERAL INDEX: \n${idx.indexDrop}\n\n`, create: '' } : { drop: '', create: `---- EXISTING GENERAL INDEX: \n${idx.indexDefinition}\n\n` }

                  const desiredRealization = currentRealization

                  const idxEvaluation = existing ? 
                    {
                      ...existing,
                      indexDisplayClass: 'red--text',
                      evaluation: MULTIPLE_INDICES,
                      indices: [...existing.indices, idx],
                      desiredRealization: {
                        drop: existing.desiredRealization.drop.concat(currentRealization.drop),
                        create: existing.desiredRealization.create.concat(currentRealization.create),
                      }
                    } :
                    {
                      id: idxKey,
                      idxKey: idxKey,
                      idxType: 'generic',
                      idxColumns: idxColumns.split(', '),
                      tableKey: `${idx.tableSchema}.${idx.tableName}`,
                      tableSchema: `${idx.tableSchema}`,
                      tableName: `${idx.tableName}`,
                      indexDisplayClass: 'green--text',
                      evaluation: idxColumns,
                      indices: [idx],
                      desiredRealization: desiredRealization
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