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
          :input-value="roleGrantSelected(props.item, 'all')" 
          @click="toggleRoleGrant(props.item.roleName, 'all')"
          :disabled="roleGrantDisabled(props.item, 'all')"
        ></v-checkbox>
      </td>
      <td>
        <v-checkbox 
          :input-value="roleGrantSelected(props.item, 'select')" 
          @click="toggleRoleGrant(props.item.roleName, 'select')"
          :disabled="roleGrantDisabled(props.item, 'select')"
        ></v-checkbox>
      </td>
      <td>
        <v-checkbox 
          :input-value="roleGrantSelected(props.item, 'insert')"
          @click="toggleRoleGrant(props.item.roleName, 'insert')"
          :disabled="roleGrantDisabled(props.item, 'insert')"
        ></v-checkbox>
      </td>
      <td>
        <v-checkbox 
          :input-value="roleGrantSelected(props.item, 'update')"
          @click="toggleRoleGrant(props.item.roleName, 'update')"
          :disabled="roleGrantDisabled(props.item, 'update')"
        ></v-checkbox>
      </td>
      <td>
        <v-checkbox 
        :input-value="roleGrantSelected(props.item, 'delete')"
          @click="toggleRoleGrant(props.item.roleName, 'delete')"
          :disabled="roleGrantDisabled(props.item, 'delete')"
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
    name: 'PolicyDefinitionGrantGrid',
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
        const currentValue = this.policy.roleGrants[toggledRoleName][action]

        const impliedRoleNames = this.projectRoles.filter(
          pr => {
            return (pr.applicableRoles || []).find(ar => ar.roleName === toggledRoleName) !== undefined
          }
        ).reduce((a,r)=>{ return a.concat(r.roleName)}, [])

        const newPolicy = {
          ...this.policy,
          roleGrants: Object.keys(this.policy.roleGrants).reduce(
            (newGrants, newRoleName) => {
              const toggledRoleIsApplicableToNew = impliedRoleNames.indexOf(newRoleName) > -1
              const newRoleIsToggledRole = newRoleName === toggledRoleName

              return {
                ...newGrants,
                [newRoleName]: Object.keys(this.policy.roleGrants[newRoleName]).reduce(
                  (newRow, newAction) => {
                    const oldValue = this.policy.roleGrants[newRoleName][newAction]
                    let newValue
                    if (action === 'all') {
                      if (newRoleIsToggledRole) {
                        newValue = currentValue === ALLOWED ? DENIED : newAction === 'all' ? ALLOWED : IMPLIED
                      } else if (toggledRoleIsApplicableToNew) {
                        newValue = currentValue === ALLOWED ? DENIED : IMPLIED
                      } else {
                        newValue = this.policy.roleGrants[newRoleName][newAction]
                      }
                    } else {
                      if (newAction === action) {
                        if (newRoleIsToggledRole) {
                          newValue = currentValue === ALLOWED ? DENIED : ALLOWED
                        } else if (toggledRoleIsApplicableToNew) {
                          newValue = currentValue === ALLOWED ? DENIED : IMPLIED
                        } else {
                          newValue = this.policy.roleGrants[newRoleName][newAction]
                        }
                      } else {
                        if (newAction == 'all') {
                          if ((toggledRoleIsApplicableToNew || newRoleIsToggledRole) && currentValue === ALLOWED) {
                            newValue = DENIED
                          } else {
                            newValue = this.policy.roleGrants[newRoleName][newAction]
                          }
                        } else {
                          newValue = this.policy.roleGrants[newRoleName][newAction]
                        }
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

        this.$store.commit('savePolicy', {
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
        return Object.keys(this.policy.roleGrants).map(
          roleName => {
            return {
              ...this.policy.roleGrants[roleName]
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
            text: 'ALL',
            sortable: false
          },
          {
            text: 'SELECT',
            sortable: false
          },
          {
            text: 'INSERT',
            sortable: false
          },
          {
            text: 'UPDATE',
            sortable: false
          },
          {
            text: 'DELETE',
            sortable: false
          }
        ]
      },
    },
  }
</script>