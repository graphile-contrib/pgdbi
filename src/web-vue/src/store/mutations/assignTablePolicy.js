function assignAll(state, payload) {
  const tableIds = payload.tableIds;
  const policyDefinitionId = payload.policyDefinitionId;

  tableIds.forEach(
    tableId => {
      state.tablePolicyAssignments[tableId] = policyDefinitionId
    }
  )
}

export default assignAll;
