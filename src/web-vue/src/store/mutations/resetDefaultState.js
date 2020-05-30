import defaultState from '../defaultState';

function resetDefaultState(state) {
  Object.keys(defaultState)
  .filter(k => ['allRoleSets'].indexOf(k) === -1)
  .forEach(key => {
    state[key] = defaultState[key];
  });
}

export default resetDefaultState;
