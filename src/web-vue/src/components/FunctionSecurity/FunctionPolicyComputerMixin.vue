<template>
</template>

<script>
  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'
  const TERSE = 'terse'
  const ALL = 'all'

  // templates for policy calculation -- this could be pushed into the defaultState and made configurable
  // not sure if it would be best to go that route, or to just refine this to an ideal form

  // security removal
  const securityRemovalHeaderTemplate = `
-------------- REMOVE EXISTING FUNCTION GRANTS ----------------------

revoke all privileges on function {{schemaName}}.{{functionName}} from public;
`

  // function grants
  const functionGrantsHeaderTemplate = `
-------------- CREATE NEW TABLE GRANTS ----------------------

`
  const revokeFunctionPrivilegesFromRoleTemplate = `revoke all privileges on function {{schemaName}}.{{functionName}} from {{roleName}};\n`

  const grantActionOnFunctionToRoleTemplate = `grant {{action}} on function {{schemaName}}.{{functionName}} to {{roleName}};\n`
  const implyGrantActionOnFunctionToRoleTemplate = `-- IMPLIED:  grant {{action}} on function {{schemaName}}.{{functionName}} to {{roleName}};\n`
  const denyGrantActionOnFunctionToRoleTemplate = `-- DENIED:  grant {{action}} on function {{schemaName}}.{{functionName}} to {{roleName}};\n`

  function applyTemplate(template, variables) {
    return Object.keys(variables).reduce(
      (result, variableName) => {
        return result.split(`{{${variableName}}}`).join(variables[variableName])
      }, template
    )
  }
  // end of template stuff

  export default {
    name: 'FunctionComputerMixin',
    methods: {
      securityRemoval (policyDefinition, policyReadability) {
        return securityRemovalHeaderTemplate
          .concat(Object.keys(policyDefinition.roleFunctionGrants).reduce(
            (all, roleName) => {
              // return all.concat(revokeFunctionPrivilegesFromRoleTemplate.split('{{roleName}}').join(roleName))
              return all.concat(applyTemplate(revokeFunctionPrivilegesFromRoleTemplate, {
                roleName: roleName
              }))
            }, ''
          )
        )
      },
      functionGrants (policyDefinition, policyReadability) {
        return functionGrantsHeaderTemplate
        .concat(Object.keys(policyDefinition.roleFunctionGrants).reduce(
          (all, roleName) => {
            const roleGrantSet = policyDefinition.roleFunctionGrants[roleName]

            return all
              // .concat(policyReadability === TERSE ? `` : `---------------------------------------------------------------------------------------------------------------------------------------${roleName}\n`)
              .concat(
                Object.keys(roleGrantSet)
                  .filter(f => f !== 'roleName')
                  .reduce(
                    (all, action) => {
                      const allInEffect = [ALLOWED, IMPLIED].indexOf(policyDefinition.roleFunctionGrants[roleName].all) > -1
                      if (roleGrantSet[action] === ALLOWED) {
                        if (allInEffect) {
                          return action === ALL 
                            ? all.concat(
                              applyTemplate(
                                  grantActionOnFunctionToRoleTemplate, {
                                  action: action,
                                  roleName: roleName
                                }
                              )
                            ) 
                            : policyReadability === TERSE
                              ? all
                              : all.concat(
                                  applyTemplate(
                                      implyGrantActionOnFunctionToRoleTemplate, {
                                      action: action,
                                      roleName: roleName
                                    }
                                  )
                                )
                        } else {
                          return all.concat(
                            applyTemplate(
                                grantActionOnFunctionToRoleTemplate, {
                                action: action,
                                roleName: roleName
                              }
                            )
                          )
                        }
                      } else if (roleGrantSet[action] === IMPLIED) {
                        return policyReadability === TERSE ? all : all.concat(
                          applyTemplate(
                              implyGrantActionOnFunctionToRoleTemplate, {
                              action: action,
                              roleName: roleName
                            }
                          )
                        )
                      } else if (roleGrantSet[action] === DENIED) {
                        return policyReadability === TERSE ? all : all.concat(
                          applyTemplate(
                              denyGrantActionOnFunctionToRoleTemplate, {
                              action: action,
                              roleName: roleName
                            }
                          )
                        )
                      }
                    }, ''
                  )
                .concat('\n')
              )
            }, ''
          )
        )
      },
      computePolicy (policyDefinition, policyReadability, variables) {
        const header = policyDefinition.functionPolicyHeaderTemplate
        const policyDefinitionName = `---------------------------------------------------------------------------POLICY DEFINITION:  ${policyDefinition.name}\n`
        const footer = policyDefinition.functionPolicyFooterTemplate
        // remove all existing theFunction grants
        const securityRemoval = this.securityRemoval(policyDefinition, policyReadability)

        // theFunction grants
        const functionGrants = this.functionGrants(policyDefinition, policyReadability)

        // rls
        const template = header.concat(policyDefinitionName).concat(securityRemoval).concat(functionGrants).concat(footer)

        return variables ? applyTemplate(template, variables) : template
      },
    },
  }
</script>