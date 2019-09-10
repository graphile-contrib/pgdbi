import Mustache from 'mustache'

const enumTemplate = `
create type {{enumSchema}}.{{enumName}} as (
  {{#enumValues}}
    '{{value}}'{{comma}}
  {{/enumValues}}
);
`

function evaluateEnumScripts(state){
  state.managedSchemata = state.managedSchemata
    .map(
      schema => {
        return {
          ...schema
          ,schemaEnums: schema.schemaEnums
            .map(
              e => {
                const enumDefinition = Mustache.render(
                  enumTemplate,
                  {
                    ...e
                    ,enumValues: e.enumValues.map(
                      (v,i) => {
                        return {
                          value: v
                          ,comma: i === e.enumValues.length -1 ? '' : ','
                        } 
                      }
                    )
                  }
                )

                return {
                  ...e
                  ,enumDefinition: enumDefinition
                }
              }
            )
        }
      }
    )
}

export default evaluateEnumScripts