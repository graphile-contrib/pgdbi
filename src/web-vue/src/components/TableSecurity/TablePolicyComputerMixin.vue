<template>
</template>

<script>
  import Mustache from 'mustache'
  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'
  const TERSE = 'terse'
  const VERBOSE = 'verbose'
  const ALL = 'all'

  export default {
    name: 'PolicyComputerMixin',
    methods: {
      computePolicy (policyDefinition, policyReadability, variables) {
        const tablePolicyTemplate = this.$store.state.tablePolicyTemplate

        const allRoles = Object.keys(policyDefinition.roleGrants).map(
          roleName => {
            return {
              roleName: roleName
            }
          }
        )

        const allRoleGrants =  Object.keys(policyDefinition.roleGrants).reduce(
          (allGrants, roleName) => {
            const grantsForRole = Object.keys(policyDefinition.roleGrants[roleName]).map(
              action => {
                return {
                  action: action,
                  value: policyDefinition.roleGrants[roleName][action]
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
          roleGrant => {
            return {
              ...roleGrant,
              grants: roleGrant.grants.filter(gfr => gfr.value === ALLOWED)
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
          enableRls: policyDefinition.enableRls,
          revokeRoles: allRoles,
          allowedRoleGrants: allowedRoleGrants,
          rlsPolicies: rlsPolicies
        }

        const templateVariables = policyReadability === TERSE ? regularVariables : {...verboseVariables, ...regularVariables}

        return Mustache.render(
          tablePolicyTemplate,
          templateVariables
        )
      },
    },
  }

</script>