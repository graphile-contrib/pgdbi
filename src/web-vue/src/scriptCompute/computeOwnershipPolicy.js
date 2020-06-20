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
        const argumentDataTypes = f.argumentDataTypes
          .split(',')
          .map(adt => adt.replace('timestamp with time zone', 'timestamptz'))
          .map(adt => adt.trim().split(' ')[1])
          .join(', ')

        return {
          ...f,
          argumentDataTypes: argumentDataTypes
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