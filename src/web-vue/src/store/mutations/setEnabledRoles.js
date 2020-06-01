function setEnabledRoles(state, payload) {
  state.isDirty = true
  state.enabledRoles = payload.enabledRoles
}

export default setEnabledRoles;
