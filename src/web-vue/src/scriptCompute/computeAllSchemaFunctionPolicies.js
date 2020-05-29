import computeSchemaFunctionPolicy from './computeSchemaFunctionPolicy'

function computeAllSchemaFunctionPolicies (state, policyReadability) {
  return state.managedSchemata
    .filter(s => !s.parked)
    .filter(s => s.schemaFunctions.length > 0)
    .reduce(
      (all, schema) => {
        const schemaFunctions = schema.schemaFunctions
        const schemaPolicy = {
          name: `${schema.schemaName}`,
          policy: computeSchemaFunctionPolicy(state, policyReadability, schemaFunctions)
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

export default computeAllSchemaFunctionPolicies