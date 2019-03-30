function importProject (state, payload) {
  Object.keys(payload.project).forEach(
    key => {
      state[key] = payload.project[key]
    }
  )
}

export default importProject