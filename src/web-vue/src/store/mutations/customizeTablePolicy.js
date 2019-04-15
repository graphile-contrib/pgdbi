function customizeTablePolicy(state, payload) {
  const sourcePolicyDefinitionId = payload.sourcePolicyDefinitionId
  const newFields = payload.newFields
  const tableIds = payload.tableIds || []

  const sourcePolicyDefinition = state.policies.find(p => p.id === sourcePolicyDefinitionId)

  const newPolicy = {
    ...sourcePolicyDefinition,
    id: (((new Date()).getTime() * 10000) + 621355968000000000),
    name: newFields.name,
    customIdentifier: tableIds.length === 1 ? tableIds[0] : null
  }

  state.policies = [...state.policies, ...[newPolicy]].sort(function(a,b){ return a.id < b.id})

  state.managedSchemata = state.managedSchemata.map(
    schema => {
      return {
        ...schema,
        schemaTables: schema.schemaTables.map(
          table => {
            return tableIds.indexOf(table.id) > -1 ? {
              ...table,
              policyDefinitionId: newPolicy.id
            } : table
          }
        )
      }
    }
  )
}

export default customizeTablePolicy