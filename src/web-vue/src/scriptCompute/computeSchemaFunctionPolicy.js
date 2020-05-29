import computeFunctionPolicy from './computeFunctionPolicy'

function computeSchemaFunctionPolicy (state, policyReadability, someFunctions) {
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

export default computeSchemaFunctionPolicy