function defaultRlsWithCheck(state, payload) {
  state.isDirty = true
  state.defaultRlsWithCheck = payload.defaultRlsWithCheck;
}

export default defaultRlsWithCheck;
