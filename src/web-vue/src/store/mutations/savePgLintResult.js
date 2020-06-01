function savePgLintResult(state, payload) {
  state.pgLintResults = [...state.pgLintResults, payload]
}

export default savePgLintResult