function newPolicy(state, payload) {
  const existing = state.policies.find(p => p.name === payload.name);
  if (existing) {
    throw new Error('A policy with this name already exists');
  } else {
    const name = payload.name;
    const dbUserRoles = state.dbUserRoles;

    const newPolicy = {
      id: new Date().getTime() * 10000 + 621355968000000000,
      name: name,
      policyHeaderTemplate: state.policyHeaderTemplate,
      policyFooterTemplate: state.policyFooterTemplate,
      enableRls: false,
      columnExclusionOverrides: {
        insert: [],
        update: [],
      },
      columnExclusions: {
        insert: {},
        update: {},
      },
      roleGrants: dbUserRoles.reduce((all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]: state.defaultRoleGrants,
        };
      }, {}),
      rlsQualifiers: dbUserRoles.reduce((all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]: state.defaultRlsQualifiers,
        };
      }, {}),
    };

    state.policies = [...state.policies, ...[newPolicy]].sort(function(a, b) {
      return a.id < b.id;
    });
  }
}

export default newPolicy;
