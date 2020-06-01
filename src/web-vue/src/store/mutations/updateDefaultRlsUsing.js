function updateDefaultRlsUsing(state, payload) {
  state.isDirty = true
  state.defaultRlsUsing = payload.defaultRlsUsing;
}

module.exports = updateDefaultRlsUsing;
