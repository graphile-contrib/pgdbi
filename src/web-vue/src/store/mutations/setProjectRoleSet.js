function setProjectRoleSet(state, payload) {
  const roleSet = state.allRoleSets.find(rs => rs.name === payload)
  state.roleSet = roleSet
}

export default setProjectRoleSet;
