  import Mustache from 'mustache'
  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'
  const TERSE = 'terse'
  const VERBOSE = 'verbose'
  const ALL = 'all'

function computePolicy (policyDefinition, policyReadability, variables, table) {
  const allRoles = Object.keys(policyDefinition.roleGrants).map(
    roleName => {
      return {
        roleName: roleName
      }
    }
  )

  const revokeRolesList = `${allRoles.map(r => r.roleName).join(', ')}`

  const allRoleGrants =  Object.keys(policyDefinition.roleGrants).reduce(
    (allGrants, roleName) => {
      const allowedGrantCount = Object.keys(policyDefinition.roleGrants[roleName]).reduce(
        (count, action) => {
          return policyDefinition.roleGrants[roleName][action] === ALLOWED ? count + 1 : count
        }, 0
      )

      const grantsForRole = Object.keys(policyDefinition.roleGrants[roleName]).map(
        (action, index, array) => {

          switch (action) {
            case 'insert':
            case 'update':
              let columnExclusions = policyDefinition.columnExclusions[action][roleName] || []
              let columnExclusionsText = columnExclusions.length > 0 ? `\n        -- excluded columns: ${columnExclusions.join(', ')}` : '\n        -- no excluded columns'
              let grantColumns = table ? 
                `( ${table.tableColumns
                  .map(tc => tc.columnName)
                  .filter(tc => columnExclusions.indexOf(tc) === -1)
                  .join(', ')} )`
                  :
                '{{grantColumns}}'
              const overrideExclusions = policyDefinition.columnExclusionOverrides[action].indexOf(roleName) > -1
              
              const value = columnExclusions.length > 0 || overrideExclusions ? ALLOWED : policyDefinition.roleGrants[roleName][action]

              return {
                action: action,
                value: value,
                grantColumns: grantColumns,
                columnExclusionsText: columnExclusionsText,
                comma: (index < allowedGrantCount - 1) ? ',' : ''
              }
            default :
              return {
                action: action,
                value: policyDefinition.roleGrants[roleName][action],
                grantColumns: '',
                comma: (index < allowedGrantCount - 1) ? ',' : ''
              }
          }
        }
      )
      return [...allGrants, {
        roleName: roleName,
        grants: grantsForRole
      }]
    }, []
  )


  // const allowedRoleGrants = allRoleGrants
  const allowedRoleGrants = allRoleGrants.map(
    (roleGrant, index, array) => {
      return {
        ...roleGrant,
        grants: roleGrant.grants.filter(gfr => gfr.value === ALLOWED),
      }
    }
  ).filter(rg => rg.grants.length > 0)

  const deniedRoleGrants = allRoleGrants.map(
    roleGrant => {
      return {
        ...roleGrant,
        grants: roleGrant.grants.filter(gfr => gfr.value === DENIED)
      }
    }
  ).filter(rg => rg.grants.length > 0)

  const impliedRoleGrants = allRoleGrants.map(
    roleGrant => {
      return {
        ...roleGrant,
        grants: roleGrant.grants.filter(gfr => gfr.value === IMPLIED)
      }
    }
  ).filter(rg => rg.grants.length > 0)


  const rlsPolicies = Object.keys(policyDefinition.rlsQualifiers).reduce(
      (allPolicySql, roleName) => {
        return allPolicySql
          .concat(Object.keys(policyDefinition.rlsQualifiers[roleName]).reduce(
            (allActions, action) => {
              return [...allActions, ...policyDefinition.rlsQualifiers[roleName][action].policies.map(
                policy => {
                  return {
                    ...policy,
                    action: action,
                    roleName: roleName
                  }
                }
              )]
            }, []
          ))
      }, []
    )

  const verboseVariables = {
    verbose: true,
    deniedRoleGrants: deniedRoleGrants,
    impliedRoleGrants: impliedRoleGrants
  }

  const regularVariables = {
    ...variables,
    policyName: policyDefinition.name,
    enableRls: policyDefinition.enableRls,
    allowedRoleGrants: allowedRoleGrants,
    rlsPolicies: rlsPolicies,
    revokeRolesList: revokeRolesList,
    tableName: (table || {}).tableName
  }

  const templateVariables = policyReadability === TERSE ? regularVariables : {...verboseVariables, ...regularVariables}

  return Mustache.render(
    tablePolicyTemplate,
    templateVariables
  )
}

export default computePolicy

const tablePolicyTemplate = `
----******
----******  BEGIN TABLE POLICY: {{schemaName}}{{^schemaName}}{{=<% %>=}}{{schemaName}}<%={{ }}=%>{{/schemaName}}.{{tableName}}{{^tableName}}{{=<% %>=}}{{tableName}}<%={{ }}=%>{{/tableName}}
----******  POLICY NAME:  {{policyName}}
----******

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table {{schemaName}}{{^schemaName}}{{=<% %>=}}{{schemaName}}<%={{ }}=%>{{/schemaName}}.{{tableName}}{{^tableName}}{{=<% %>=}}{{tableName}}<%={{ }}=%>{{/tableName}} 
  from public;

  revoke all privileges 
  on table {{schemaName}}{{^schemaName}}{{=<% %>=}}{{schemaName}}<%={{ }}=%>{{/schemaName}}.{{tableName}}{{^tableName}}{{=<% %>=}}{{tableName}}<%={{ }}=%>{{/tableName}} 
  from {{revokeRolesList}};

{{#enableRls}}
----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = '{{schemaName}}'
        and tablename = '{{tableName}}'
      loop
        _drop_sql := 'drop policy if exists ' || quote_ident(_pol.policyname) || ' on ' || quote_ident(_pol.schemaname) || '.' || quote_ident(_pol.tablename) || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table {{schemaName}}{{^schemaName}}{{=<% %>=}}{{schemaName}}<%={{ }}=%>{{/schemaName}}.{{tableName}}{{^tableName}}{{=<% %>=}}{{tableName}}<%={{ }}=%>{{/tableName}} enable row level security;

{{#rlsPolicies}}
  create policy {{name}}_{{schemaName}}{{^schemaName}}{{=<% %>=}}{{schemaName}}<%={{ }}=%>{{/schemaName}}_{{tableName}}{{^tableName}}{{=<% %>=}}{{tableName}}<%={{ }}=%>{{/tableName}} 
    on {{schemaName}}{{^schemaName}}{{=<% %>=}}{{schemaName}}<%={{ }}=%>{{/schemaName}}.{{tableName}}{{^tableName}}{{=<% %>=}}{{tableName}}<%={{ }}=%>{{/tableName}}
    as {{passStrategy}}
    for {{action}}
    to {{roleName}}
    using {{{using}}}
    {{#withCheck}}
    with check {{withCheck}}
    {{/withCheck}}
    ;
{{/rlsPolicies}}

{{/enableRls}}
{{^enableRls}}
----------  DISABLE ROW LEVEL SECURITY

  alter table {{schemaName}}{{^schemaName}}{{=<% %>=}}{{schemaName}}<%={{ }}=%>{{/schemaName}}.{{tableName}}{{^tableName}}{{=<% %>=}}{{tableName}}<%={{ }}=%>{{/tableName}} disable row level security;
{{/enableRls}}

----------  CREATE NEW TABLE GRANTS
{{#allowedRoleGrants}}

----------  {{roleName}}
  grant 
  {{#grants}}
    {{action}} {{grantColumns}}{{comma}} {{columnExclusionsText}}
  {{/grants}}
  on table {{schemaName}}{{^schemaName}}{{=<% %>=}}{{schemaName}}<%={{ }}=%>{{/schemaName}}.{{tableName}}{{^tableName}}{{=<% %>=}}{{tableName}}<%={{ }}=%>{{/tableName}} 
  to {{roleName}};

{{/allowedRoleGrants}}

{{#verbose}}
----------  IMPLIED TABLE GRANTS
  {{#impliedRoleGrants}}

  ----------  {{roleName}}
  {{#grants}}
  --IMPLIED:   grant {{action}} on table {{schemaName}}{{^schemaName}}{{=<% %>=}}{{schemaName}}<%={{ }}=%>{{/schemaName}}.{{tableName}}{{^tableName}}{{=<% %>=}}{{tableName}}<%={{ }}=%>{{/tableName}} to {{roleName}};
  {{/grants}}
  {{/impliedRoleGrants}}

  ----------  DENIED TABLE GRANTS
  {{#deniedRoleGrants}}

  ----------  {{roleName}}
  {{#grants}}
  --DENIED:   grant {{action}} on table {{schemaName}}{{^schemaName}}{{=<% %>=}}{{schemaName}}<%={{ }}=%>{{/schemaName}}.{{tableName}}{{^tableName}}{{=<% %>=}}{{tableName}}<%={{ }}=%>{{/tableName}} to {{roleName}};
  {{/grants}}
  {{/deniedRoleGrants}}
{{/verbose}}

----======  END TABLE POLICY: {{schemaName}}{{^schemaName}}{{=<% %>=}}{{schemaName}}<%={{ }}=%>{{/schemaName}}.{{tableName}}{{^tableName}}{{=<% %>=}}{{tableName}}<%={{ }}=%>{{/tableName}}
--==`
