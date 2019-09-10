import evaluateFkIndexes from './evaluateFkIndexes'
import evaluateUqIndexes from './evaluateUqIndexes'
import evaluateGenericIndices from './evaluateGenericIndices'
import evaluateEnumScripts from './evaluateEnumScripts'
import evaluateUdtScripts from './evaluateUdtScripts'


function evaluateAll(state){
  evaluateFkIndexes(state)
  evaluateUqIndexes(state)
  evaluateGenericIndices(state)
  evaluateEnumScripts(state)
  evaluateUdtScripts(state)
}

export default evaluateAll