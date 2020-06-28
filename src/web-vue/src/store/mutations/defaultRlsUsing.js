function defaultRlsUsing(state, payload) {
  state.isDirty = true
  state.defaultRlsUsing = payload;
}

export default defaultRlsUsing;
