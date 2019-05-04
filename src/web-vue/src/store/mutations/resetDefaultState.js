import defaultState from '../defaultState'
import resetOrm from '../orm/resetOrm'

function resetDefaultState (state) {
  Object.keys(defaultState).forEach(
    key => {
      state[key] = defaultState[key]
    }
  )

  resetOrm()
}

export default resetDefaultState