import {getApolloClient} from '@/vue-apollo'
import getPgdbirc from '@/gql/query/pgdbirc.graphql'

async function pgdbirc() {
  const apolloClient = getApolloClient()

  const queryResult = await apolloClient.query({
    query: getPgdbirc,
    fetchPolicy: 'network-only'
  })

  return queryResult.data.PGDBIRC.pgdbirc
}

export default pgdbirc
