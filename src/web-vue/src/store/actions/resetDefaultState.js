import getGetPgdbirc from './pgdbirc'

async function resetDefaultState(context) {
  const pgdbirc = await getGetPgdbirc()
  await context.commit('resetDefaultState', pgdbirc)
}

export default resetDefaultState
