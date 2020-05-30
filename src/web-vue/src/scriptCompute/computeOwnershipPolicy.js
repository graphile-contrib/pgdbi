import Mustache from 'mustache'

const ownershipPolicyTemplate = `
----------
----------  BEGIN OWNERSHIP SQL
----------

{{#schemata}}
----------  SCHEMA: {{schemaName}}
  ALTER SCHEMA {{schemaName}} OWNER TO {{dbOwnerRole}};
  -- tables
  {{#schemaTables}}
    ALTER TABLE {{schemaName}}.{{tableName}} OWNER TO {{dbOwnerRole}};
  {{/schemaTables}}
  -- functions
  {{#schemaFunctions}}
    ALTER FUNCTION {{schemaName}}.{{functionName}}({{argumentDataTypes}}) OWNER TO {{dbOwnerRole}};
  {{/schemaFunctions}}
----------  END SCHEMA: {{schemaName}}
{{/schemata}}
----------
----------  END OWNERSHIP SQL
----------
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
      dbOwnerRole: state.roleSet.dbOwnerRole.roleName
    }
  ).split("&#39;").join("'")
}

export default computeOwnershipPolicy