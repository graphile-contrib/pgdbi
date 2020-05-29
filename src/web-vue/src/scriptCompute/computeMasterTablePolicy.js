import computeAllSchemaTablePolicies from './computeAllSchemaTablePolicies'

function computeMasterTablePolicy (state, policyReadability) {
  const masterPolicyName = 'All Schemata - Tables'
  const schemaTablePolicies = computeAllSchemaTablePolicies(state, policyReadability)
  const masterPolicy = schemaTablePolicies.reduce(
    (m, p) => {
      return m.concat(p.policy)
    }, ''
  )

  return {
    name: masterPolicyName,
    policy: masterPolicy
  }

}

export default computeMasterTablePolicy