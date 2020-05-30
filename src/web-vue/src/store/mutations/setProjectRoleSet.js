import roleSets from '../roleSets'

function setProjectRoleSet(state, payload) {
  const roleSet = roleSets.find(rs => rs.name === payload)
  state.roleSet = roleSet

  // state.roleSet.dbOwnerRole = roleSet.roles.dbOwnerRole
  // state.roleSet.dbAuthenticatorRole = roleSet.roles.dbAuthenticatorRole
  // state.roleSet.dbUserRoles = roleSet.roles.dbUserRoles
}

export default setProjectRoleSet;
