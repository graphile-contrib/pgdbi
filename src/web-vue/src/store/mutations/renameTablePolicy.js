function renameTablePolicy(state, payload) {
  state.isDirty = true
  const policy = state.policies.find(p => p.id === payload.policyDefinitionId)
  const others = state.policies.filter(p => p.id !== payload.policyDefinitionId)

  state.policies = [
    ...others,
    {
      ...policy,
      name: payload.name
    }
  ]
}

export default renameTablePolicy;
