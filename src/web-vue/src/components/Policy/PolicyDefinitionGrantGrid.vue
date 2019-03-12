<template>
    <div>
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
    </div>
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
        return roleGrant[action] === IMPLIED
      },
      toggleRoleGrant(roleName, action) {
        if (this.toggleCompleted === true) {
          this.toggleCompleted = false
          return
        }

        const toggledRole = this.projectRoles.find(pr => pr.roleName === roleName)
        const currentValue = this.policy.roleGrants[roleName][action]
        const newValue = [ALLOWED, IMPLIED].indexOf(currentValue) > -1 ? DENIED : ALLOWED

        const roleGrants = Object.keys(this.policy.roleGrants).reduce(
          (all, newRoleName) => {
            const projectRole = this.projectRoles.find(r => r.roleName === newRoleName)
            return {
              ...all,
              [newRoleName]: ['all', 'select', 'insert', 'update', 'delete'].reduce(
                (all, newAction) => {
                  const oldRoleActionValue = this.policy.roleGrants[newRoleName][newAction]
                  const newRoleIsApplicableToToggled = projectRole.applicableRoles.find(ar => ar.roleName === toggledRole.roleName) !== undefined
                  const toggledRoleIsApplicableToNew = toggledRole.applicableRoles.find(ar => ar.roleName === projectRole.roleName) !== undefined
                  const newRoleIsToggledRole = projectRole.roleName === toggledRole.roleName

                  let newRoleActionValue = oldRoleActionValue

                  if (newAction === action) {
                    if (newValue === ALLOWED) {
                      // all roles with toggledRole as applicable should be IMPLIED
                      if (newRoleName === roleName) {
                        newRoleActionValue = newValue
                      } else {
                        newRoleActionValue = newRoleIsApplicableToToggled ? 'IMPLIED' : this.policy.roleGrants[newRoleName][newAction]
                      }
                    } else {  // newValue === ALLOWED
                      // all applicable roles should be DENIED
                      newRoleActionValue = newRoleIsApplicableToToggled || newRoleIsToggledRole ? 'DENIED' : this.policy.roleGrants[newRoleName][newAction]
                    }
                  } else {  // newAction === action
                    newRoleActionValue = oldRoleActionValue
                  }

                  return {
                    ...all,
                    [newAction]: newRoleActionValue
                  }
                }, {}
              )
            }
          }, {}
        )

        this.$store.commit('savePolicy', {
            policy: {
              ...this.policy,
              roleGrants: roleGrants
            }
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