function assignAll(state, payload) {
  const functionIds = payload.functionIds;
  const policyDefinitionId = payload.policyDefinitionId;

  functionIds.forEach(
    functionId => {
      state.functionPolicyAssignments[functionId] = policyDefinitionId
    }
  )
}

export default assignAll;
