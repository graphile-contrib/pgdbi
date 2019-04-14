function assignTablePolicy (state, tableId, policyDefinitionId) {
  // console.log('tableId', tableId)
  // console.log('poli', policyDefinitionId)
  // console.log('state', state)
  const stuff = state.managedSchemata.reduce(
    (stuff, schema) => {
      if (stuff.currentSchema) {
        return stuff
      } else {
        const table = schema.schemaTables.find(t => t.id === tableId)
        if (table) {
          return {
            ...stuff,
            currentSchema: schema,
            currentTable: table
          }
        } else {
          return stuff
        }
      }
    }, {
      currentSchema: null,
      currentTable: null
    }
  )

  const schema = stuff.currentSchema
  const table = stuff.currentTable

  const otherSchemata = state.managedSchemata.filter (s => s.id !== schema.id)
  const otherTables = schema.schemaTables.filter(t => t.id !== table.id)

  state.managedSchemata = [
    ...otherSchemata,
    {
      ...schema,
      schemaTables: [
        ...otherTables,
        {
          ...table,
          policyDefinitionId: policyDefinitionId
        }
      ]
    }
  ]

  return state
}

function assignAll(state, payload) {
  const tableIds = payload.tableIds
  const policyDefinitionId = payload.policyDefinitionId
// console.log('tableIds', tableIds)
  tableIds.reduce(
    (state, tableId) => {
      return assignTablePolicy (state, tableId, policyDefinitionId)
    }, state
  )
}

export default assignAll