// mutations.spec.js
import { expect } from 'chai';
import { mutations } from './store';

// destructure assign `mutations`
const { resetDefaultState } = mutations;

describe('resetDefaultState', () => {
  const state = {};

  resetDefaultState(state);

  expect(state).to.be.an('Object');
});
