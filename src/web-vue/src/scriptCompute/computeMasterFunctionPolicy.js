import computeAllSchemaFunctionPolicies from './computeAllSchemaFunctionPolicies'

function computeMasterFunctionPolicy (state, policyReadability) {
  const masterPolicyName = 'All Schemata - Functions'
  const schemaFunctionPolicies = computeAllSchemaFunctionPolicies(state, policyReadability)
  const masterPolicy = schemaFunctionPolicies.reduce(
    (m, p) => {
      return m.concat(p.policy)
    }, ''
  )

  return {
    name: masterPolicyName,
    policy: masterPolicy
  }
}

export default computeMasterFunctionPolicy