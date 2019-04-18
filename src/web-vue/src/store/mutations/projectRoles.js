function projectRoles (state, payload) {
  const projectRoles = state.projectRoles = payload.projectRoles.map(
    role => {
      return {
        ...role,
        applicableRoles: role.applicableRoles || []
      }
    }
  )

  state.policies = state.policies.map(
    policy => {
      return {
        ...policy,
        roleGrants: projectRoles.reduce(
          (all, projectRole) => {
            // const existing = policy.roleGrants[projectRole.name]
    
            return {
              ...all,
              [projectRole.roleName]: policy.roleGrants[projectRole.name] || state.defaultRoleGrants
            }
          }, {}
        ),
        rlsQualifiers: projectRoles.reduce(
          (all, projectRole) => {
            // const existing = Object.keys(policy.rlsQualifiers).find(rn => rn === projectRole.roleName)
    
            return {
              ...all,
              [projectRole.roleName]: policy.rlsQualifiers[projectRole.name] || state.defaultRlsQualifiers
            }
          }, {}
        )
      }
    }
  )

  state.functionPolicies = state.functionPolicies.map(
    policy => {
      return {
        ...policy,
        roleFunctionGrants: projectRoles.reduce(
          (all, projectRole) => {
            // const existing = Object.keys(policy.roleFunctionGrants).find(rn => rn === projectRole.roleName)
    
            return {
              ...all,
              [projectRole.roleName]: policy.roleFunctionGrants[projectRole.name] || state.defaultFunctionRoleGrants
            }
          }, {}
        )
      }
    }
  )
}

export default projectRoles