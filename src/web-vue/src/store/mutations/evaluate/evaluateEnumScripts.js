function evaluateEnumScripts(state){
  state.managedSchemata = state.managedSchemata
    .map(
      schema => {
        return {
          ...schema
          ,schemaEnums: schema.schemaEnums
            .map(
              e => {
                return {
                  ...e
                  ,enumDefinition: `
CREATE TYPE ${e.enumSchema}.${e.enumName} AS ENUM (
  '${e.enumValues.join(`', \n  '`)}'
);                  
`
                }
              }
            )
        }
      }
    )
}

export default evaluateEnumScripts