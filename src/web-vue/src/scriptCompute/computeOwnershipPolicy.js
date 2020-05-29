import Mustache from 'mustache'

const ownershipPolicyTemplate = `
----------
----------  BEGIN OWNERSHIP POLICY
----------  POLICY NAME
----------

{{#schemata}}
----------  SCHEMA: {{schemaName}}
  ALTER SCHEMA {{schemaName}} OWNER TO {{dbOwnerRole}};
  {{#schemaTables}}
    ALTER TABLE {{schemaName}}.{{tableName}} OWNER TO {{dbOwnerRole}};
  {{/schemaTables}}
  {{#schemaFunctions}}
    ALTER FUNCTION {{schemaName}}.{{functionName}}({{argumentDataTypes}}) OWNER TO {{dbOwnerRole}};
  {{/schemaFunctions}}
----------  END SCHEMA: {{schemaName}}

{{/schemata}}


----------  END OWNERSHIP POLICY
--==

`

const computeOwnershipPolicy = (state) => {
  const sortedSchemata = state.managedSchemata
  .sort((a,b)=>{
    if ( a.schemaName < b.schemaName ){
      return -1;
    }
    if ( a.schemaName > b.schemaName ){
      return 1;
    }
    return 0;
  })
  .map(s=>{
    return {
      ...s,
      schemaFunctions: s.schemaFunctions.map(f=>{
        return {
          ...f,
          // argumentDataTypes: f.argumentDataTypes.split("'").join("")
        }
      })
    }
  })

  return Mustache.render(
    ownershipPolicyTemplate,
    {
      schemata: sortedSchemata,
      dbOwnerRole: state.dbOwnerRole.roleName
    }
  ).split("&#39;").join("'")
}

export default computeOwnershipPolicy