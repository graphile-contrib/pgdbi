function defaultRlsUsing(state, payload) {
  state.isDirty = true
  state.defaultRlsUsing = payload.defaultRlsUsing;
}

export default defaultRlsUsing;
