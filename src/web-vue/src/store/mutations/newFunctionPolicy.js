function newFunctionPolicy(state, payload) {
  state.isDirty = true
  const existing = state.policies.find(p => p.name === payload.name);
  if (existing) {
    throw new Error('A policy with this name already exists');
  } else {
    const name = payload.name;
    const dbUserRoles = state.roleSet.dbUserRoles;

    const newPolicy = {
      id: new Date().getTime() * 10000 + 621355968000000000,
      name: name,
      functionPolicyHeaderTemplate: state.functionPolicyHeaderTemplate,
      functionPolicyFooterTemplate: state.functionPolicyFooterTemplate,
      roleFunctionGrants: dbUserRoles.reduce((all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]: state.defaultFunctionRoleGrants,
        };
      }, {}),
    };

    state.functionPolicies = [...state.functionPolicies, ...[newPolicy]].sort(
      function(a, b) {
        return a.id < b.id;
      },
    );
  }
}

export default newFunctionPolicy;
