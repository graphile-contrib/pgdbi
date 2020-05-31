// import computeRemoveRls from './computeRemoveRls'
import computeSchemaTablePolicy from './computeSchemaTablePolicy'

function computeAllSchemaTablePolicies (state, policyReadability) {
  return state.managedSchemata
    .filter(s => !s.parked)
    .filter(s => s.schemaTables.length > 0)
    .reduce(
      (all, schema) => {
        const schemaTables = schema.schemaTables.filter(t => t.tableType === 'BASE TABLE')
        // const schemaRemoveRls = computeRemoveRls(schema.schemaName)
        
        const schemaPolicy = {
          name: `${schema.schemaName}`,
          policy: computeSchemaTablePolicy(state, policyReadability, schemaTables)
        }
        return all.concat([schemaPolicy])
      }, []
    )
    .sort(
      (a,b)=>{ 
        return a.name < b.name ? -1 : 1
      }
    )
}

export default computeAllSchemaTablePolicies