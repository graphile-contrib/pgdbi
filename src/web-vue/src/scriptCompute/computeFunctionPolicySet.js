import computeFunctionPolicy from './computeFunctionPolicy'

function calcOnePolicy (state, policyReadability, someFunctions) {
  const retval = someFunctions.sort((a,b)=>{return a.functionname < b.functionname ? -1 : 1}).reduce(
    (policy, aFunction) => {
      const policyTemplate = state.functionPolicies.find(p => p.id === state.functionPolicyAssignments[aFunction.id].policyDefinitionId)
      const variables = {
      }
      const aFunctionPolicy = computeFunctionPolicy(policyTemplate, policyReadability, variables, aFunction)
      return policy.concat(aFunctionPolicy)
    }, ''
  )
  return retval
}

function computeFunctionPolicySet (state, policyReadability) {
  const masterPolicyName = 'One Script To Rule Them All'
  const mostPolicies = state.managedSchemata
    .filter(s => !s.parked)
    .filter(s => s.schemaFunctions.length > 0)
    .reduce(
      (all, schema) => {
        const schemaFunctions = schema.schemaFunctions
        const schemaPolicy = {
          name: `${schema.schemaName}`,
          policy: calcOnePolicy(state, policyReadability, schemaFunctions)
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

export default computeFunctionPolicySet