<template>
    <div :key="policy.id">
      <h1>Policy Name: {{ policy.name }}</h1>
      <v-layout justify-center>
        <v-checkbox v-model="enableRls" label="Enable Rls"></v-checkbox>
      </v-layout>
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
      <v-toolbar>
        <v-btn @click="expand">Expand</v-btn>
        <!-- <button 
          v-clipboard:copy="computedPolicy"
        >Copy</button> -->
      </v-toolbar>
      <v-textarea
        :value="computedPolicy"
        auto-grow
      >
      </v-textarea>
    </div>
</template>

<script>

  export default {
    name: 'PolicyDefinition',
    props: {
      policyId: {
        type: Number,
        required: true
      }
    },
    data () {
      return {
        enableRls: true,
        policyStructure: [],
        calculatedPolicy: 'NOT CALCULATED',
        toggleCompleted: false
      }
    },
    watch: {
      enableRls () {
        if (!this.policyStructure) {
          return
        }

        if (this.enableRls) {
          this.policyStructure = this.policyStructure.map(
            row => {
              return {
                ...this.policyStructure,
                qual: this.defaultRlsQual
              }
            }
          )
        } else {
          this.policyStructure = {
            qual,
            ...this.policyStructure
          }
        }
      }
    },
    methods: {
      expand () {
        this.$store.commit('savePolicy', {
            policy: {
              ...this.policy,
              roleGrants: {
                ...this.policy.roleGrants,
                soro_admin: {
                  select: true,
                  insert: true,
                  update: true,
                  delete: true
                }
              }
            }
          }
        )
      },
      roleGrantSelected(roleGrant, action) {
        return ['ALLOWED', 'IMPLIED'].indexOf(roleGrant[action]) > -1
      },
      roleGrantDisabled(roleGrant, action) {
        return false;
        // return roleGrant[action] === 'IMPLIED'
      },
      toggleRoleGrant(roleName, action) {
        if (this.toggleCompleted === true) {
          this.toggleCompleted = false
          return
        }

        const toggledRole = this.projectRoles.find(pr => pr.roleName === roleName)
        const currentValue = this.policy.roleGrants[roleName][action]
        const newValue = ['ALLOWED', 'IMPLIED'].indexOf(currentValue) > -1 ? 'DENIED' : 'ALLOWED'

        const roleGrants = Object.keys(this.policy.roleGrants).reduce(
          (all, newRoleName) => {
            const projectRole = this.projectRoles.find(r => r.roleName === newRoleName)
            return {
              ...all,
              [newRoleName]: Object.keys(this.policy.roleGrants[newRoleName]).reduce(
                (all, newAction) => {
                  const oldRoleActionValue = this.policy.roleGrants[newRoleName][newAction]
                  const newRoleIsApplicableToSelected = projectRole.applicableRoles.find(ar => ar.roleName === roleName)

                  const newActionValue = 
                    newAction !== action
                      ? newValue === 'ALLOWED' 
                        ? oldRoleActionValue
                        : toggledRole.applicableRoles.find(ar => ar.roleName === newRoleName) !== undefined 
                          ? 'DENIED' 
                          : oldRoleActionValue
                      : newRoleName === roleName 
                        ? newValue
                        : newRoleIsApplicableToSelected
                          ? newValue === 'ALLOWED' ? 'IMPLIED' : oldRoleActionValue
                          : oldRoleActionValue
                            
                  return {
                    ...all,
                    [newAction]: newActionValue
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
      policy () {
        const policies = this.$store.state.policies
        const pol = this.$store.state.policies.find(p => p.id === this.policyId)
        return pol
      },
      computedPolicy () {
        const header = this.policyHeaderTemplate
        const footer = this.policyFooterTemplate
        const tableGrants = Object.keys(this.policy.roleGrants).reduce(
          (all, roleName) => {
            const roleGrantSet = this.policy.roleGrants[roleName]
            return all.concat(Object.keys(roleGrantSet)
              .filter(f => f !== 'roleName')
              .reduce(
                (all, action) => {
                  return ['ALLOWED', 'IMPLIED'].indexOf(roleGrantSet[action]) > -1 ?
                    all.concat(`${roleName} -- ${action}\n`) :
                    all
                }, ''
              ))
            }, ''
        )

        return header.concat(tableGrants).concat(footer)
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
      policyHeaderTemplate () {
        return this.policy.policyHeaderTemplate
      },
      policyFooterTemplate () {
        return this.policy.policyFooterTemplate
      },
      roleTableGrantTemplate () {
        return this.policy.roleTableGrantTemplate
      },
      defaultRlsQual () {
        return this.$store.state.defaultRlsQual
      },
      headers () {
        const hdrs = [
          {
            text: 'Role Name',
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