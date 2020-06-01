function updateTablePolicyTemplate(state, payload) {
  state.isDirty = true
  state.tablePolicyTemplate = payload.tablePolicyTemplate;
}

export default updateTablePolicyTemplate;
