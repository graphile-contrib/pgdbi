function initialize (state) {
  if (state.policies.length === 0) {
    state.policies = []
    state.defaultPolicy = null
  }
}

export default initialize