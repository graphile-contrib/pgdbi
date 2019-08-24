function evaluateFunctionPolicy(functionId, policyDefinitionId) {
  return {
    functionId: functionId
    ,policyDefinitionId: policyDefinitionId
    ,evaluation: {
      status: 'PASS'
      ,errors: []
    }
  }
}

function assignAll(state, payload) {
  const functionIds = payload.functionIds;
  const policyDefinitionId = payload.policyDefinitionId;

  functionIds.forEach(
    functionId => {
      state.functionPolicyAssignments[functionId] = evaluateFunctionPolicy(functionId, policyDefinitionId)
    }
  )
}

export default assignAll;
