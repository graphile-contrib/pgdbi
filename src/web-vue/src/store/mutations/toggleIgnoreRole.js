function toggleIgnoreRole(state, payload) {
  const isIgnored = state.ignoredRoles.find(i => i.roleName === payload.role.roleName)

  state.ignoredRoles = isIgnored ? state.ignoredRoles.filter(i => i.roleName !== payload.role.roleName) : [...state.ignoredRoles, payload.role]
}

export default toggleIgnoreRole;
