function toggleIndexForDrop(state, payload) {
  if (payload.value === true && !state.indicesToDrop[payload.item.id]) {  // add the index
    const indexId = payload.item.id
    state.indicesToDrop = {
      ...state.indicesToDrop,
      [indexId]: payload.item
    }
  } else if (payload.value === false) {
    state.indicesToDrop = Object.keys(state.indicesToDrop)
      .filter(k => k !== payload.item.id)
      .reduce(
        (all, k) => {
          return {
            ...all,
            [k]: state.indicesToDrop[k]
          }
        }, {}
      )
  }
}

export default toggleIndexForDrop;
