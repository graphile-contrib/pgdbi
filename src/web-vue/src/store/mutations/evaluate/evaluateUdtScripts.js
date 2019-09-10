import Mustache from 'mustache'

const udtTemplate = `
create type {{udtSchema}}.{{udtName}} as (
  {{#fields}}
    {{fieldName}} {{dataType}}{{comma}}
  {{/fields}}
);
`

function evaluateUdtScripts(state){
  state.managedSchemata = state.managedSchemata
    .map(
      schema => {
        return {
          ...schema
          ,schemaUdts: schema.schemaUdts
            .map(
              e => {
                const udtDefinition = Mustache.render(
                  udtTemplate,
                  {
                    ...e
                    ,fields: e.fields.map(
                      (f, i) => {
                        return {
                          ...f
                          ,comma: i === e.fields.length -1 ? '' : ','
                        }
                      }
                    )
                  }
                )

                return {
                  ...e
                  ,udtDefinition: udtDefinition
                }
              }
            )
        }
      }
    )
}

export default evaluateUdtScripts