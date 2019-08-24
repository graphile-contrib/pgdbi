function evaluateTablePolicy(tableId, policyDefinitionId) {
  return {
    tableId: tableId
    ,policyDefinitionId: policyDefinitionId
    ,evaluation: {
      status: 'PASS'
      ,errors: []
    }
  }
}

function assignAll(state, payload) {
  const tableIds = payload.tableIds;
  const policyDefinitionId = payload.policyDefinitionId;

  tableIds.forEach(
    tableId => {
      state.tablePolicyAssignments[tableId] = evaluateTablePolicy(tableId, policyDefinitionId)
    }
  )
}

export default assignAll;
