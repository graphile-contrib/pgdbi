import {getApolloClient} from '@/vue-apollo'
import writeArtifacts from '@/gql/mutation/writeArtifacts.graphql'
import computeMasterSecurityPolicy from '@/scriptCompute/computeMasterSecurityPolicy'
import computeOwnershipPolicy from '@/scriptCompute/computeOwnershipPolicy'
import computeSchemaUsageSql from '@/scriptCompute/computeSchemaUsageSql'
import computeMasterTablePolicy from '@/scriptCompute/computeMasterTablePolicy'
import computeMasterFunctionPolicy from '@/scriptCompute/computeMasterFunctionPolicy'
// import {
//   computeAllSchemaFunctionPolicies,
//   computeAllSchemaTablePolicies,
//   computeFunctionPolicy,
//   computeMasterFunctionPolicy,
//   computeMasterSecurityPolicy,
//   computeMasterTablePolicy,
//   computeOwnershipPolicy,
//   computeRemoveRls,
//   computeRolesSql,
//   computeSchemaFunctionPolicy,
//   computeSchemaTablePolicy,
//   computeSchemaUsageSql,
//   computeTablePolicy
// } from '@/scriptCompute'

async function writeToDisk({state}) {
  const apolloClient = getApolloClient()

  const masterSecurityPolicy = computeMasterSecurityPolicy(state)
  const ownershipPolicy = computeOwnershipPolicy(state)
  const schemaUsageSql = computeSchemaUsageSql(state)
  const masterTablePolicy = computeMasterTablePolicy(state)
  const masterFunctionPolicy = computeMasterFunctionPolicy(state)

  await apolloClient.mutate({
    mutation: writeArtifacts,
    variables: {
      projectState: state,
      masterSecurityPolicy: masterSecurityPolicy,
      ownershipPolicy: ownershipPolicy,
      schemaUsageSql: schemaUsageSql,
      masterTablePolicy: masterTablePolicy.policy,
      masterFunctionPolicy: masterFunctionPolicy.policy
    }
  })

  state.isDirty = false

  return `write to disk complete`
}

export default writeToDisk;
