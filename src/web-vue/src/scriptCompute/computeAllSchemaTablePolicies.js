import computeTablePolicy from './computeTablePolicy'
import computeRemoveRls from './computeRemoveRls'

function calcOnePolicy (state, policyReadability, tables) {
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

function computeAllSchemaTablePolicies (state, policyReadability) {
  const masterPolicyName = 'One Script To Rule Them All'
  const mostPolicies = state.managedSchemata
    .filter(s => !s.parked)
    .filter(s => s.schemaTables.length > 0)
    .reduce(
      (all, schema) => {
        const schemaTables = schema.schemaTables.filter(t => t.tableType === 'BASE TABLE')
        const schemaRemoveRls = computeRemoveRls(schema.schemaName)
        
        const schemaPolicy = {
          name: `${schema.schemaName}`,
          policy: calcOnePolicy(state, policyReadability, schemaTables)
        }
        return all.concat([schemaPolicy])
      }, []
    )
    .sort(
      (a,b)=>{ 
        return a.name < b.name ? -1 : 1
      }
    )

  const masterPolicy = mostPolicies.reduce(
    (m, p) => {
      return m.concat(p.policy)
    }, ''
  )

  return [
    ...mostPolicies,
    {
      name: masterPolicyName,
      policy: masterPolicy
    }
  ]
}

export default computeAllSchemaTablePolicies