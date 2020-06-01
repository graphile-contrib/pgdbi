import defaultState from '../defaultState';

function resetDefaultState(state, pgdbirc) {
  Object.keys(defaultState)
  .forEach(key => {
    state[key] = (pgdbirc[key] || defaultState[key]);
  });
  state.isDirty = false
}

export default resetDefaultState;
