function dbUserRoles(state, payload) {
  const dbUserRoles = (state.dbUserRoles = payload.dbUserRoles.map(role => {
    return {
      ...role,
      applicableRoles: role.applicableRoles || [],
    };
  }));

  state.policies = state.policies.map(policy => {
    return {
      ...policy,
      roleGrants: dbUserRoles.reduce((all, projectRole) => {
        // const existing = policy.roleGrants[projectRole.name]

        return {
          ...all,
          [projectRole.roleName]:
            policy.roleGrants[projectRole.name] || state.defaultRoleGrants,
        };
      }, {}),
      rlsQualifiers: dbUserRoles.reduce((all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]:
            policy.rlsQualifiers[projectRole.name] ||
            state.defaultRlsQualifiers,
        };
      }, {}),
    };
  });

  state.functionPolicies = state.functionPolicies.map(policy => {
    return {
      ...policy,
      roleFunctionGrants: dbUserRoles.reduce((all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]:
            policy.roleFunctionGrants[projectRole.name] ||
            state.defaultFunctionRoleGrants,
        };
      }, {}),
    };
  });

  const projectRoleNames = dbUserRoles.map(pr => pr.roleName)

  state.ignoredRoles = state.ignoredRoles.filter(ir => projectRoleNames.indexOf(ir.roleName) === -1)
}

export default dbUserRoles;
