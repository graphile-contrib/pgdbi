<template>
</template>

<script>
  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'

  export default {
    name: 'PolicyComputerMixin',
    methods: {
      securityRemoval (policyDefinition, policyReadability) {
        return `
-------------- REMOVE EXISTING TABLE GRANTS ----------------------

revoke all privileges on table {{schemaName}}.{{tableName}} from public;
`
          .concat(Object.keys(policyDefinition.roleGrants).reduce(
            (all, roleName) => {
              return all.concat(`revoke all privileges on table {{schemaName}}.{{tableName}} from ${roleName};\n`)
            }, ''
          )
        )
      },
      tableGrants (policyDefinition, policyReadability) {
        return `
-------------- CREATE NEW TABLE GRANTS ----------------------

`
        .concat(Object.keys(policyDefinition.roleGrants).reduce(
          (all, roleName) => {
            const roleGrantSet = policyDefinition.roleGrants[roleName]

            return all
              .concat(policyReadability === 'terse' ? `` : `---------------------------------------------------------------------------------------------------------------------------------------${roleName}\n`)
              .concat(Object.keys(roleGrantSet)
              .filter(f => f !== 'roleName')
              .reduce(
                (all, action) => {
                  const allInEffect = [ALLOWED, IMPLIED].indexOf(policyDefinition.roleGrants[roleName].all) > -1
                  if (roleGrantSet[action] === ALLOWED) {
                    if (allInEffect) {
                      return action === 'all' 
                        ? all.concat(`grant ${action} on table {{schemaName}}.{{tableName}} to ${roleName};\n`) 
                        : policyReadability === 'terse'
                          ? all
                          : all.concat(`-- IMPLIED:  ${action} on table {{schemaName}}.{{tableName}} to ${roleName}\n`)
                    } else {
                      return all.concat(`grant ${action} on table {{schemaName}}.{{tableName}} to ${roleName};\n`)
                    }
                  } else if (roleGrantSet[action] === IMPLIED) {
                    return policyReadability === 'terse' ? all : all.concat(`-- IMPLIED:  ${action} on table {{schemaName}}.{{tableName}} to ${roleName}\n`)
                  } else if (roleGrantSet[action] === DENIED) {
                    return policyReadability === 'terse' ? all : all.concat(`-- DENIED:   ${action} on table {{schemaName}}.{{tableName}} to ${roleName}\n`)
                  }
                }, ''
              ))
            }, ''
          )
        )
      },
      rlsSection (policyDefinition, policyReadability) {
        return !policyDefinition.enableRls ? `
-------------- DISABLE ROW LEVEL SECURITY ----------------------

alter table {{schemaName}}.{{tableName}} disable row level security;

`
: `
-------------- ENABLE ROW LEVEL SECURITY ----------------------

alter table {{schemaName}}.{{tableName}} enable row level security;

`
          .concat(Object.keys(policyDefinition.rlsQualifiers).reduce(
            (allPolicySql, roleName) => {
              return allPolicySql
                .concat(policyReadability === 'terse' ? `` : `---------------------------------------------------------------------------------------------------------------------------------------${roleName}\n`)
                .concat(Object.keys(policyDefinition.rlsQualifiers[roleName]).reduce(
                  (allActions, action) => {
                    return allActions.concat(
                      policyDefinition.rlsQualifiers[roleName][action].policies.reduce(
                        (allActionPolicies, actionPolicy) => {
                          return allActionPolicies.concat(`
create policy ${actionPolicy.name} on {{schemaName}}.{{tableName}}
  as ${actionPolicy.passStrategy}
  for ${action}
  to ${roleName}
  using ${actionPolicy.using}${(actionPolicy.withCheck && actionPolicy.withCheck) !== '' ? `\n  with check ${actionPolicy.withCheck}` : ''}
  ;
`
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

        if (variables) {
          return Object.keys(variables).reduce(
            (template, variable) => {
              return template.split(`{{${variable}}}`).join(variables[variable])
            }, template
          )          
        } else {
          return template
        }
      },
    },
  }
</script>