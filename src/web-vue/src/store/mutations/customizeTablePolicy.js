import assignTablePolicy from './assignTablePolicy'

function customizeTablePolicy(state, payload) {
  state.isDirty = true
  const sourcePolicyDefinitionId = payload.sourcePolicyDefinitionId;
  const newFields = payload.newFields;
  const tableIds = payload.tableIds || [];

  const sourcePolicyDefinition = state.policies.find(
    p => p.id === sourcePolicyDefinitionId,
  );

  const newPolicy = {
    ...sourcePolicyDefinition,
    id: new Date().getTime() * 10000 + 621355968000000000,
    name: newFields.name,
    customIdentifier: tableIds.length === 1 ? tableIds[0] : null,
  };

  state.policies = [...state.policies, newPolicy]
    .sort(function(a, b) {
      return a.id < b.id;
    });

  assignTablePolicy(state, {
    tableIds: tableIds,
    policyDefinitionId: newPolicy.id
  });
}

export default customizeTablePolicy;
