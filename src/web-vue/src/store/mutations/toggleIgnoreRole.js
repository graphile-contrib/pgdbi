function toggleIgnoreRole(state, payload) {
  state.isDirty = true
  const isIgnored = state.ignoredRoles.find(i => i.roleName === payload.role.roleName)

  state.ignoredRoles = isIgnored ? state.ignoredRoles.filter(i => i.roleName !== payload.role.roleName) : [...state.ignoredRoles, payload.role]
}

export default toggleIgnoreRole;
