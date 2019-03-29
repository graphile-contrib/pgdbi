// function updatePolicyRoles (policy, projectRoles) {
//   return {
//     ...policy,
//     roleGrants: projectRoles.reduce(
//       (all, projectRole) => {
//         const existing = Object.keys(policy.roleGrants).find(rn => rn === projectRole.roleName)

//         return {
//           ...all,
//           [projectRole.roleName]: existing || state.defaultRoleGrants
//         }
//       }, {}
//     ),
//     rlsQualifiers: projectRoles.reduce(
//       (all, projectRole) => {
//         const existing = Object.keys(policy.rlsQualifiers).find(rn => rn === projectRole.roleName)

//         return existing ? all : {
//           ...all,
//           [projectRole.roleName]: existing || defaultRlsQualifiers
//         }
//       }, {}
//     )
//   }
// }

function projectRoles (state, payload) {
  const projectRoles = state.projectRoles = payload.projectRoles

  state.policies = state.policies.map(
    policy => {
      return {
        ...policy,
        roleGrants: projectRoles.reduce(
          (all, projectRole) => {
            const existing = Object.keys(policy.roleGrants).find(rn => rn === projectRole.roleName)
    
            return {
              ...all,
              [projectRole.roleName]: existing || state.defaultRoleGrants
            }
          }, {}
        ),
        rlsQualifiers: projectRoles.reduce(
          (all, projectRole) => {
            const existing = Object.keys(policy.rlsQualifiers).find(rn => rn === projectRole.roleName)
    
            return existing ? all : {
              ...all,
              [projectRole.roleName]: existing || state.defaultRlsQualifiers
            }
          }, {}
        )
      }
    }
  )
}

export default projectRoles