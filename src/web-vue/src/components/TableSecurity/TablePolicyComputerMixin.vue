<template>
</template>

<script>
  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'
  const TERSE = 'terse'
  const ALL = 'all'

  // templates for policy calculation
  // security removal
  const securityRemovalHeaderTemplate = `
-------------- REMOVE EXISTING TABLE GRANTS ----------------------

revoke all privileges on table {{schemaName}}.{{tableName}} from public;
`

  // table grants
  const tableGrantsHeaderTemplate = `
-------------- CREATE NEW TABLE GRANTS ----------------------

`
  const revokeTablePrivilegesFromRoleTemplate = `revoke all privileges on table {{schemaName}}.{{tableName}} from {{roleName}};\n`

  const grantActionOnTableToRoleTemplate = `grant {{action}} on table {{schemaName}}.{{tableName}} to {{roleName}};\n`
  const implyGrantActionOnTableToRoleTemplate = `-- IMPLIED:  grant {{action}} on table {{schemaName}}.{{tableName}} to {{roleName}};\n`
  const denyGrantActionOnTableToRoleTemplate = `-- DENIED:  grant {{action}} on table {{schemaName}}.{{tableName}} to {{roleName}};\n`

  // rlsSection
  const disableRlsHeaderTemplate = `
-------------- DISABLE ROW LEVEL SECURITY ----------------------

alter table {{schemaName}}.{{tableName}} disable row level security;

`
  const enableRlsHeaderTemplate = `
-------------- ENABLE ROW LEVEL SECURITY ----------------------

alter table {{schemaName}}.{{tableName}} enable row level security;

`

  const rlsActionPolicyTemplate = `
create policy {{name}}_{{schemaName}}_{{tableName}} on {{schemaName}}.{{tableName}}
  as {{passStrategy}}
  for {{action}}
  to {{roleName}}
  using {{using}}
  ;
`
  const rlsActionPolicyWithWithCheckTemplate = `
create policy {{name}}_{{schemaName}}_{{tableName}} on {{schemaName}}.{{tableName}}
  as {{passStrategy}}
  for {{action}}
  to {{roleName}}
  using {{using}}
  with check {{withCheck}}
  ;
`

  function applyTemplate(template, variables) {
    return Object.keys(variables).reduce(
      (result, variableName) => {
        return result.split(`{{${variableName}}}`).join(variables[variableName])
      }, template
    )
  }

  export default {
    name: 'PolicyComputerMixin',
    methods: {
      securityRemoval (policyDefinition, policyReadability) {
        return securityRemovalHeaderTemplate
          .concat(Object.keys(policyDefinition.roleGrants).reduce(
            (all, roleName) => {
              // return all.concat(revokeTablePrivilegesFromRoleTemplate.split('{{roleName}}').join(roleName))
              return all.concat(applyTemplate(revokeTablePrivilegesFromRoleTemplate, {
                roleName: roleName
              }))
            }, ''
          )
        )
      },
      tableGrants (policyDefinition, policyReadability) {
        return tableGrantsHeaderTemplate
        .concat(Object.keys(policyDefinition.roleGrants).reduce(
          (all, roleName) => {
            const roleGrantSet = policyDefinition.roleGrants[roleName]

            return all
              // .concat(policyReadability === TERSE ? `` : `---------------------------------------------------------------------------------------------------------------------------------------${roleName}\n`)
              .concat(Object.keys(roleGrantSet)
              .filter(f => f !== 'roleName')
              .reduce(
                (all, action) => {
                  const allInEffect = [ALLOWED, IMPLIED].indexOf(policyDefinition.roleGrants[roleName].all) > -1
                  if (roleGrantSet[action] === ALLOWED) {
                    if (allInEffect) {
                      return action === ALL 
                        ? all.concat(
                          applyTemplate(
                              grantActionOnTableToRoleTemplate, {
                              action: action,
                              roleName: roleName
                            }
                          )
                        ) 
                        : policyReadability === TERSE
                          ? all
                          : all.concat(
                              applyTemplate(
                                  implyGrantActionOnTableToRoleTemplate, {
                                  action: action,
                                  roleName: roleName
                                }
                              )
                            )
                    } else {
                      return all.concat(
                        applyTemplate(
                            grantActionOnTableToRoleTemplate, {
                            action: action,
                            roleName: roleName
                          }
                        )
                      )
                    }
                  } else if (roleGrantSet[action] === IMPLIED) {
                    return policyReadability === TERSE ? all : all.concat(
                      applyTemplate(
                          implyGrantActionOnTableToRoleTemplate, {
                          action: action,
                          roleName: roleName
                        }
                      )
                    )
                  } else if (roleGrantSet[action] === DENIED) {
                    return policyReadability === TERSE ? all : all.concat(
                      applyTemplate(
                          denyGrantActionOnTableToRoleTemplate, {
                          action: action,
                          roleName: roleName
                        }
                      )
                    )
                  }
                }, ''
              ).concat('\n'))
            }, ''
          )
        )
      },
      rlsSection (policyDefinition, policyReadability) {
        return (!policyDefinition.enableRls ? disableRlsHeaderTemplate : enableRlsHeaderTemplate)
          .concat(Object.keys(policyDefinition.rlsQualifiers).reduce(
            (allPolicySql, roleName) => {
              return allPolicySql
                .concat(Object.keys(policyDefinition.rlsQualifiers[roleName]).reduce(
                  (allActions, action) => {
                    return allActions.concat(
                      policyDefinition.rlsQualifiers[roleName][action].policies.reduce(
                        (allActionPolicies, actionPolicy) => {
                          return applyTemplate(
                            (actionPolicy.withCheck && actionPolicy.withCheck !== '' ? rlsActionPolicyWithWithCheckTemplate : rlsActionPolicyTemplate),
                            {
                              ...actionPolicy,
                              action: action,
                              roleName: roleName,
                            }
                          )
                        }, ''
                      )
                    )
                  }, ''
                ))
            }, ''
          ))
      },
      computePolicy (policyDefinition, policyReadability, variables) {
        const header = policyDefinition.policyHeaderTemplate
        const policyDefinitionName = `---------------------------------------------------------------------------POLICY DEFINITION:  ${policyDefinition.name}\n`
        const footer = policyDefinition.policyFooterTemplate
        // remove all existing table grants
        const securityRemoval = this.securityRemoval(policyDefinition, policyReadability)

        // table grants
        const tableGrants = this.tableGrants(policyDefinition, policyReadability)

        // rls
        const rlsSection = this.rlsSection(policyDefinition, policyReadability)

        const template = header.concat(policyDefinitionName).concat(securityRemoval).concat(tableGrants).concat(rlsSection).concat(footer)

        return variables ? applyTemplate(template, variables) : template
      },
    },
  }
</script>