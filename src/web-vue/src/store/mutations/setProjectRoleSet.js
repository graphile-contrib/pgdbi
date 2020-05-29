import roleSets from '../roleSets'

function setProjectRoleSet(state, payload) {
  const roleSet = roleSets.find(rs => rs.name === payload)

  state.dbOwnerRole = roleSet.roles.dbOwnerRole
  state.dbAuthenticatorRole = roleSet.roles.dbAuthenticatorRole
  state.dbUserRoles = roleSet.roles.dbUserRoles
}

export default setProjectRoleSet;
