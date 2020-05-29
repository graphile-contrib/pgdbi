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

  return Mustache.render(
    ownershipPolicyTemplate,
    {
      schemata: sortedSchemata,
      dbOwnerRole: state.dbOwnerRole.roleName
    }
  )
}

export default computeOwnershipPolicy