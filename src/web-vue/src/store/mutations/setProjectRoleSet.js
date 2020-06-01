function setProjectRoleSet(state, payload) {
  state.isDirty = true
  const roleSet = state.allRoleSets.find(rs => rs.name === payload)
  state.roleSet = roleSet
}

export default setProjectRoleSet;
