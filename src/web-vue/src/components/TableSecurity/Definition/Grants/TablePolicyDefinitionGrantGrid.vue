<template>
  <v-data-table
    :headers="headers"
    :items="grantMatrix"
    hide-default-footer
    item-key="id"
    class="text-sm-left"
  >
    <template v-slot:item.select="{ item }">
      <v-checkbox 
        :input-value="roleGrantSelected(item, 'select')" 
        @click="toggleRoleGrant(item.roleName, 'select')"
        :disabled="roleGrantDisabled(item, 'select')"
      ></v-checkbox>
    </template>

    <template v-slot:item.insert="{ item }">
      <v-checkbox 
        :input-value="roleGrantSelected(item, 'insert')" 
        @click="toggleRoleGrant(item.roleName, 'insert')"
        :disabled="roleGrantDisabled(item, 'insert')"
      ></v-checkbox>
    </template>

    <template v-slot:item.update="{ item }">
      <v-checkbox 
        :input-value="roleGrantSelected(item, 'update')" 
        @click="toggleRoleGrant(item.roleName, 'update')"
        :disabled="roleGrantDisabled(item, 'update')"
      ></v-checkbox>
    </template>

    <template v-slot:item.delete="{ item }">
      <v-checkbox 
        :input-value="roleGrantSelected(item, 'delete')" 
        @click="toggleRoleGrant(item.roleName, 'delete')"
        :disabled="roleGrantDisabled(item, 'delete')"
      ></v-checkbox>
    </template>
    <!-- <template slot="items" slot-scope="props">
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
    </template> -->
  </v-data-table>
</template>

<script>
  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'

  export default {
    name: 'PolicyDefinitionGrantGrid',
    props: {
      policyDefinition: {
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
        console.log('policy current', this.policyDefinition)
        const currentValue = this.policyDefinition.roleGrants[toggledRoleName][action]
        console.log('currentValue', currentValue)
        console.log('this.projectRoles', this.projectRoles)

        const impliedRoleNames = this.projectRoles.filter(
          pr => {
            return (pr.applicableRoles || []).find(ar => ar.roleName === toggledRoleName) !== undefined
          }
        ).reduce((a,r)=>{ return a.concat(r.roleName)}, [])
        console.log('implied', impliedRoleNames)

        const newPolicy = {
          ...this.policyDefinition,
          roleGrants: Object.keys(this.policyDefinition.roleGrants).reduce(
            (newGrants, newRoleName) => {
              const toggledRoleIsApplicableToNew = impliedRoleNames.indexOf(newRoleName) > -1
              const newRoleIsToggledRole = newRoleName === toggledRoleName

              return {
                ...newGrants,
                [newRoleName]: Object.keys(this.policyDefinition.roleGrants[newRoleName]).reduce(
                  (newRow, newAction) => {
                    const oldValue = this.policyDefinition.roleGrants[newRoleName][newAction]
                    let newValue
                    if (newAction === action) {
                      if (newRoleIsToggledRole) {
                        newValue = currentValue === ALLOWED ? DENIED : ALLOWED
                      } else if (toggledRoleIsApplicableToNew) {
                        newValue = currentValue === ALLOWED ? DENIED : IMPLIED
                      } else {
                        newValue = this.policyDefinition.roleGrants[newRoleName][newAction]
                      }
                    } else {
                      if (newAction == 'all') {
                        if ((toggledRoleIsApplicableToNew || newRoleIsToggledRole) && currentValue === ALLOWED) {
                          newValue = DENIED
                        } else {
                          newValue = this.policyDefinition.roleGrants[newRoleName][newAction]
                        }
                      } else {
                        newValue = this.policyDefinition.roleGrants[newRoleName][newAction]
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
        return Object.keys(this.policyDefinition.roleGrants).map(
          roleName => {
            return {
              ...this.policyDefinition.roleGrants[roleName]
              ,roleName: roleName
            }
          }
        )
      },
      headers () {
        return [
          {
            text: 'Role Name',
            sortable: false,
            value: 'roleName'
          },
          {
            text: 'SELECT',
            sortable: false,
            value: 'select'
          },
          {
            text: 'INSERT',
            sortable: false,
            value: 'insert'
          },
          {
            text: 'UPDATE',
            sortable: false,
            value: 'update'
          },
          {
            text: 'DELETE',
            sortable: false,
            value: 'delete'
          }
        ]
      },
    },
  }
</script>