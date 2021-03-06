function saveFunctionPolicy(state, payload) {
  state.isDirty = true
  const functionPolicies = state.functionPolicies.filter(
    p => p.id !== payload.policy.id,
  );
  state.functionPolicies = [...functionPolicies, ...[payload.policy]].sort(
    (a, b) => {
      return a.id - b.id;
    },
  );
}

export default saveFunctionPolicy;
