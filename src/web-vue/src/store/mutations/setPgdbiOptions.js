function setPgdbiOptions(state, payload) {
  state.isDirty = true
  state.pgdbiOptions = payload.pgdbiOptions
}

export default setPgdbiOptions;
