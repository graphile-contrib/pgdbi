import {getApolloClient} from '@/vue-apollo'
import project from '@/gql/query/project.graphql'

async function loadFromDisk({commit}) {
  const apolloClient = getApolloClient()

  const queryResult = await apolloClient.query({
    query: project,
    fetchPolicy: 'network-only'
  })
  
  const theProject = queryResult.data.project.project

  commit('importProject', {
    project: theProject
  })

}

export default loadFromDisk
