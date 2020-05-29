import computeTablePolicy from './computeTablePolicy'

function computeSchemaTablePolicy (state, policyReadability, tables) {
  return tables.sort((a,b)=>{return a.tablename < b.tablename ? -1 : 1}).reduce(
    (policy, table) => {
      const policyTemplate = state.policies.find(p => p.id === state.tablePolicyAssignments[table.id].policyDefinitionId)
      const variables = {
        schemaName: table.tableSchema,
        tableName: table.tablename
      }
      const tablePolicy = computeTablePolicy(policyTemplate, policyReadability, variables, table)
      return policy.concat(tablePolicy)
    }, ''
  )
}

export default computeSchemaTablePolicy