import defaultState from '../defaultState';

function resetDefaultState(state) {
  Object.keys(defaultState).forEach(key => {
    state[key] = defaultState[key];
  });
}

export default resetDefaultState;
