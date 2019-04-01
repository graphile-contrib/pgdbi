<template>
  <v-data-table
    :headers="headers"
    :items="grantMatrix"
    hide-actions
    item-key="id"
    class="text-sm-left"
  >
    <template slot="items" slot-scope="props">
      <td>{{ props.item.roleName }}</td>          
      <td>
        <v-checkbox 
          :input-value="roleGrantSelected(props.item, 'execute')" 
          @click="toggleRoleGrant(props.item.roleName, 'execute')"
          :disabled="roleGrantDisabled(props.item, 'execute')"
        ></v-checkbox>
      </td>
    </template>
  </v-data-table>
</template>

<script>
  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'

  export default {
    name: 'FunctionPolicyDefinitionGrantGrid',
    props: {
      policy: {
        type: Object,
        required: true
      },
      disabled: {
        type: Boolean,
        default: false
      }
    },
    data () {
      return {
        policyStructure: [],
        calculatedPolicy: 'NOT CALCULATED',
        toggleCompleted: false
      }
    },
    watch: {
    },
    methods: {
      roleGrantSelected(roleGrant, action) {
        return [ALLOWED, IMPLIED].indexOf(roleGrant[action]) > -1
      },
      roleGrantDisabled(roleGrant, action) {
        // return false;
        return (roleGrant[action] === IMPLIED) || this.disabled
      },
      toggleRoleGrant(toggledRoleName, action) {
        if (this.toggleCompleted === true) {
          this.toggleCompleted = false
          return
        }
        const currentValue = this.policy.roleFunctionGrants[toggledRoleName][action]

        const impliedRoleNames = this.projectRoles.filter(
          pr => {
            return pr.applicableRoles.find(ar => ar.roleName === toggledRoleName) !== undefined
          }
        ).reduce((a,r)=>{ return a.concat(r.roleName)}, [])

        const newPolicy = {
          ...this.policy,
          roleFunctionGrants: Object.keys(this.policy.roleFunctionGrants).reduce(
            (newGrants, newRoleName) => {
              const toggledRoleIsApplicableToNew = impliedRoleNames.indexOf(newRoleName) > -1
              const newRoleIsToggledRole = newRoleName === toggledRoleName

              return {
                ...newGrants,
                [newRoleName]: Object.keys(this.policy.roleFunctionGrants[newRoleName]).reduce(
                  (newRow, newAction) => {
                    const oldValue = this.policy.roleFunctionGrants[newRoleName][newAction]
                    let newValue
                    
                    if (newAction === action) {
                      if (newRoleIsToggledRole) {
                        newValue = currentValue === ALLOWED ? DENIED : ALLOWED
                      } else if (toggledRoleIsApplicableToNew) {
                        newValue = currentValue === ALLOWED ? DENIED : IMPLIED
                      } else {
                        newValue = this.policy.roleFunctionGrants[newRoleName][newAction]
                      }
                    } else {
                      if (newAction == 'all') {
                        if ((toggledRoleIsApplicableToNew || newRoleIsToggledRole) && currentValue === ALLOWED) {
                          newValue = DENIED
                        } else {
                          newValue = this.policy.roleFunctionGrants[newRoleName][newAction]
                        }
                      } else {
                        newValue = this.policy.roleFunctionGrants[newRoleName][newAction]
                      }
                    }

                    return {
                      ...newRow,
                      [newAction]: newValue
                    }
                  }, {}
                )
              }
            }, {}
          )
        }

        this.$store.commit('saveFunctionPolicy', {
            policy: newPolicy
          }
        )
        this.toggleCompleted = true
      },
    },
    computed: {
      projectRoles () {
        return this.$store.state.projectRoles
      },
      grantMatrix () {
        return Object.keys(this.policy.roleFunctionGrants).map(
          roleName => {
            return {
              ...this.policy.roleFunctionGrants[roleName]
              ,roleName: roleName
            }
          }
        )
      },
      headers () {
        return [
          {
            text: 'Role Name',
            sortable: false
          },
          {
            text: 'EXECUTE',
            sortable: false
          }
        ]
      },
    },
  }
</script>