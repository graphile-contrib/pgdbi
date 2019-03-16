
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
          <td v-for="action in ['all', 'select', 'insert', 'update', 'delete']" :key="action">
            <v-btn
              @click="toggleRlsPolicy(props.item.roleName, action)"
              :hidden="props.item[action].status === 'ENABLED'"
            >{{rlsQualifierCheckLabel(props.item, action)}}</v-btn>
            <rls-policy-dialog
              :action="action"
              :roleName="props.item.roleName"
              :rlsPolicy="props.item[action]"
              :disableRlsPolicy="disableRlsPolicy"
              :updateRlsPolicy="updateRlsPolicy"
            ></rls-policy-dialog>
          </td>
        </template>
      </v-data-table>
    </div>
</template>

<script>
  const ENABLED = 'ENABLED'
  const DISABLED = 'DISABLED'
  const IMPLIED = 'IMPLIED'
  import RlsPolicyDialog from './RlsPolicyDialog.vue'

  export default {
    name: 'PolicyRlsQualifierGrid',
    components: {
      RlsPolicyDialog
    },
    props: {
      policy: {
        type: Object,
        required: true
      }
    },
    data () {
      return {
        toggleCompleted: false,
        dialog: false,
        currentUsing: 'n/a',
        currentWithCheck: 'n/a'
      }
    },
    watch: {
    },
    methods: {
      disableRlsPolicy (roleName, action) {
        console.log('disableRlsPolicy', action, roleName)
        this.toggleRlsPolicy(roleName, action)
      },
      updateRlsPolicy (roleName, action, currentUsing, currentWithCheck) {
        console.log('updateRlsPolicy', roleName, action, currentUsing, currentWithCheck)
        const newPolicy = {
          ...this.policy,
          rlsQualifiers: {
            ...this.policy.rlsQualifiers,
            [roleName]: {
              ...this.policy.rlsQualifiers[roleName],
              [action]: {
                status: this.policy.rlsQualifiers[roleName][action].status,
                using: currentUsing,
                withCheck: currentWithCheck
              }
            }
          }
        }
        // console.log(JSON.stringify(this.policy,0,2))
        // console.log(JSON.stringify(newPolicy,0,2))
        this.$store.commit('savePolicy', {
            policy: newPolicy
          }
        )

      },
      editRlsPolicy(rlsPolicy, action) {
        console.log('edit', rlsPolicy, action)
        this.currentEditRlsPolicy = rlsPolicy
        this.currentEditAction
        this.currentUsing = rlsPolicy[action].using
        this.currentWithCheck = rlsPolicy[action].withCheck
      },
      rlsQualifierCheckLabel(rlsPolicy, action) {
        switch(rlsPolicy[action].status) {
          case ENABLED:
            return 'Disable'
            break;
          case DISABLED:
            return 'Enable'
            break;
          case IMPLIED:
            return 'Override'
            break;
        }
      },
      toggleRlsPolicy(toggledRoleName, action) {
        const currentValue = this.policy.rlsQualifiers[toggledRoleName][action].status

        const impliedRoleNames = this.projectRoles.filter(
          pr => {
            return pr.applicableRoles.find(ar => ar.roleName === toggledRoleName) !== undefined
          }
        ).reduce((a,r)=>{ return a.concat(r.roleName)}, [])

        const newPolicy = {
          ...this.policy,
          rlsQualifiers: Object.keys(this.policy.rlsQualifiers).reduce(
            (newRlsQualifiers, newRoleName) => {
              const toggledRoleIsApplicableToNew = impliedRoleNames.indexOf(newRoleName) > -1
              const newRoleIsToggledRole = newRoleName === toggledRoleName

              return {
                ...newRlsQualifiers,
                [newRoleName]: Object.keys(this.policy.rlsQualifiers[newRoleName]).reduce(
                  (newRow, newAction) => {
                    const oldValue = this.policy.rlsQualifiers[newRoleName][newAction].status
                    const oldRoleAction = this.policy.rlsQualifiers[newRoleName][newAction]
                    
                    let newValue
                    if (action === 'all') {
                      if (newRoleIsToggledRole) {
                        newValue = currentValue === ENABLED ? DISABLED : newAction === 'all' ? ENABLED : IMPLIED
                      } else if (toggledRoleIsApplicableToNew) {
                        newValue = currentValue === ENABLED ? DISABLED : IMPLIED
                      } else {
                        newValue = this.policy.rlsQualifiers[newRoleName][newAction].status
                      }
                    } else {
                      if (newAction === action) {
                        if (newRoleIsToggledRole) {
                          newValue = currentValue === ENABLED ? DISABLED : ENABLED
                        } else if (toggledRoleIsApplicableToNew) {
                          newValue = currentValue === ENABLED ? DISABLED : IMPLIED
                        } else {
                          newValue = this.policy.rlsQualifiers[newRoleName][newAction].status
                        }
                      } else {
                        if (newAction == 'all') {
                          if ((toggledRoleIsApplicableToNew || newRoleIsToggledRole) && currentValue === ENABLED) {
                            newValue = DISABLED
                          } else {
                            newValue = this.policy.rlsQualifiers[newRoleName][newAction].status
                          }
                        } else {
                          newValue = this.policy.rlsQualifiers[newRoleName][newAction].status
                        }
                      }

                    }

                    return {
                      ...newRow,
                      [newAction]: {
                        ...oldRoleAction,
                        status: newValue
                      }
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

<style>
.norm-text {
  text-transform: none !important;
}
</style>