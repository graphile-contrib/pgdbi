function deleteTablePolicy(state, payload) {
  state.isDirty = true
  const policyDefinitionId = payload.policyDefinitionId;

  const otherPolicies = state.policies.filter(p => p.id !== policyDefinitionId);

  state.policies = [...otherPolicies].sort(function(a, b) {
    return a.id < b.id;
  });

  Object.keys(state.tablePolicyAssignments).forEach(
    tableId => {
      if (state.tablePolicyAssignments[tableId] === policyDefinitionId) {
        state.tablePolicyAssignments[tableId] = state.defaultPolicy.id
      }
    }
  )
}

export default deleteTablePolicy;
