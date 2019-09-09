import evaluateFkIndexes from './evaluateFkIndexes'
import evaluateUqIndexes from './evaluateUqIndexes'
import evaluateGenericIndices from './evaluateGenericIndices'

function evaluateAll(state){
  evaluateFkIndexes(state)
  evaluateUqIndexes(state)
  evaluateGenericIndices(state)
}

export default evaluateAll