function makeGlobalTablePolicy(state, payload) {
  const policyDefinitionId = payload.policyDefinitionId
  const newFields = payload.newFields

  const existing = state.policies.find(p => p.name === newFields.name)
  if (existing) {
    throw new Error('A policy with this name already exists')
  } else {

    const policyDefinition = state.policies.find(p => p.id === policyDefinitionId)
    const otherPolicies = state.policies.filter(p => p.id !== policyDefinition.id)

    const newGlobalPolicy = {
      ...policyDefinition,
      name: newFields.name,
      customIdentifier: null
    }

    state.policies = [...otherPolicies, ...[newGlobalPolicy]].sort(function(a,b){ return a.id < b.id})
  }
}

export default makeGlobalTablePolicy