
<template>
    <div>
      <v-data-table
        :headers="headers"
        :items="rlsQualifierMatrix"
        hide-actions
        item-key="id"
        class="text-sm-left"
      >
        <template slot="items" slot-scope="props">
          <td>{{ props.item.roleName }}</td>          
          <td>
            <v-toolbar>
              <v-checkbox 
                :input-value="rlsQualifierSelected(props.item, 'all')" 
                @click="toggleRoleGrant(props.item.roleName, 'all')"
                :disabled="rlsQualifierDisabled(props.item, 'all')"
              ></v-checkbox>
              <v-text-field
                class="caption"
                :value="rlsQualifierDisplayValue(props.item, 'all')" 
              ></v-text-field>
            </v-toolbar>
          </td>
          <td>
            <v-text-field
              class="caption"
              :value="rlsQualifierDisplayValue(props.item, 'select')" 
            ></v-text-field>
          </td>
          <td>
            <v-text-field
              class="caption"
              :value="rlsQualifierDisplayValue(props.item, 'insert')" 
            ></v-text-field>
          </td>
          <td>
            <v-text-field
              class="caption"
              :value="rlsQualifierDisplayValue(props.item, 'update')" 
            ></v-text-field>
          </td>
          <td>
            <v-text-field
              class="caption"
              :value="rlsQualifierDisplayValue(props.item, 'delete')" 
            ></v-text-field>
          </td>
        </template>
      </v-data-table>
    </div>
</template>

<script>
  const ENABLED = 'ENABLED'
  const DISABLED = 'DISABLED'
  const IMPLIED = 'IMPLIED'

  export default {
    name: 'PolicyRlsQualifierGrid',
    props: {
      policy: {
        type: Object,
        required: true
      }
    },
    data () {
      return {
        toggleCompleted: false
      }
    },
    watch: {
    },
    methods: {
      rlsQualifierDisplayValue(rlsQualifier, action) {
        // console.log(action, rlsQualifier)
        switch (rlsQualifier[action].status) {
          case ENABLED:
            return rlsQualifier[action].using
            break;
          case IMPLIED:
            return IMPLIED
            break;
          case DISABLED:
            return DISABLED          
            break;
        }
      },
      rlsQualifierSelected(rlsQualifier, action) {
        return [ENABLED, IMPLIED].indexOf(rlsQualifier[action].status) > -1
      },
      rlsQualifierDisabled(rlsQualifier, action) {
        // return false;
        return rlsQualifier[action] === IMPLIED
      },
      toggleRoleGrant(roleName, action) {
        if (this.toggleCompleted === true) {
          this.toggleCompleted = false
          return
        }
        console.log(roleName, action)

        const toggledRole = this.projectRoles.find(pr => pr.roleName === roleName)
        const currentValue = this.policy.rlsQualifiers[roleName][action].status
        const newValue = [ENABLED, IMPLIED].indexOf(currentValue) > -1 ? DISABLED : ENABLED

        const rlsQualifiers = Object.keys(this.policy.rlsQualifiers).reduce(
          (all, newRoleName) => {
            const projectRole = this.projectRoles.find(r => r.roleName === newRoleName)
            return {
              ...all,
              [newRoleName]: ['all', 'select', 'insert', 'update', 'delete'].reduce(
                (all, newAction) => {
                  const oldRoleAction = this.policy.rlsQualifiers[newRoleName][newAction]
                  const oldRoleActionValue = oldRoleAction.status
                  const newRoleIsApplicableToToggled = projectRole.applicableRoles.find(ar => ar.roleName === toggledRole.roleName) !== undefined
                  const toggledRoleIsApplicableToNew = toggledRole.applicableRoles.find(ar => ar.roleName === projectRole.roleName) !== undefined
                  const newRoleIsToggledRole = projectRole.roleName === toggledRole.roleName

                  let newRoleActionValue = oldRoleActionValue
// console.log('newActionValue', newRoleActionValue)
                  if (newAction === action) {
                    if (newValue === ENABLED) {
                      // all roles with toggledRole as applicable should be IMPLIED
                      if (newRoleName === roleName) {
                        newRoleActionValue = newValue
                      } else {
                        newRoleActionValue = newRoleIsApplicableToToggled ? IMPLIED : this.policy.rlsQualifiers[newRoleName][newAction].status
                      }
                    } else {  // newValue === ENABLED
                      // all applicable roles should be DISABLED
                      newRoleActionValue = newRoleIsApplicableToToggled || newRoleIsToggledRole ? DISABLED : this.policy.rlsQualifiers[newRoleName][newAction].status
                    }
                  } else {  // newAction === action
                    newRoleActionValue = oldRoleActionValue
                  }
// console.log(newAction, newRoleName, newRoleActionValue, oldRoleAction)
                  return {
                    ...all,
                    [newAction]: {
                      ...oldRoleAction,
                      status: newRoleActionValue
                    }
                  }
                }, {}
              )
            }
          }, {}
        )
console.log('rlsQualifiers', rlsQualifiers)

        this.$store.commit('savePolicy', {
            policy: {
              ...this.policy,
              rlsQualifiers: rlsQualifiers
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
      defaultRLSQual () {
        return this.$store.state.defaultRLSQual
      },
      rlsQualifierMatrix () {
        console.log('pol', this.policy)
        return Object.keys(this.policy.rlsQualifiers).map(
          roleName => {
            return {
              ...this.policy.rlsQualifiers[roleName]
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