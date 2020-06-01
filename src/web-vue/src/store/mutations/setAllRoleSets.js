function setAllRoleSets(state, payload) {
  state.isDirty = true
  state.allRoleSets = payload
}

export default setAllRoleSets;
