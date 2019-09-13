function storeEvaluations(state, evaluations){
  const indexEvaluations = Object.keys(evaluations)
  .reduce(
    (all, k) => {
      const existing = state.indexEvaluations[k]
      const thisEvaluation = existing ? [...existing, ...evaluations[k]] : evaluations[k]
      // console.log('evaluations', evaluations)
      // console.log('evaluations[k]', k, evaluations[k])
      // console.log('existing', existing)
      // console.log('thisEvaluation', thisEvaluation)
      return thisEvaluation.length === 0 ? all : {
        ...all
        ,[thisEvaluation[0].idxKey]: thisEvaluation
      }
    }, {}
  )

  state.indexEvaluations = {
    ...state.indexEvaluations,
    ...indexEvaluations
  }
}

export default storeEvaluations