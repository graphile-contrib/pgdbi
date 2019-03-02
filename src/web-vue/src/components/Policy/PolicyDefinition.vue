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
          <td><v-checkbox :input-value="props.item.select" @click="toggleRoleGrant(props.item.roleName, 'select')"></v-checkbox></td>
          <td><v-checkbox :input-value="props.item.insert" @click="toggleRoleGrant(props.item.roleName, 'insert')"></v-checkbox></td>
          <td><v-checkbox :input-value="props.item.update" @click="toggleRoleGrant(props.item.roleName, 'update')"></v-checkbox></td>
          <td><v-checkbox :input-value="props.item.delete" @click="toggleRoleGrant(props.item.roleName, 'delete')"></v-checkbox></td>
          <td>{{ props.item.qual }}</td>
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
      policyName: {
        type: String,
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
                  delete: true,
                  rlsQualifier: 'RLS QUALIFIER'
                }
              }
            }
          }
        )
      },
      toggleRoleGrant(roleName, action) {
        if (this.toggleCompleted === true) {
          this.toggleCompleted = false
          return
        }

        console.log(roleName, action)

        this.$store.commit('savePolicy', {
            policy: {
              ...this.policy,
              roleGrants: {
                ...this.policy.roleGrants,
                [roleName]: {
                  ...this.policy.roleGrants[roleName],
                  [action]: !(this.policy.roleGrants[roleName][action])
                }
              }
            }
          }
        )
        this.toggleCompleted = true
      },
    },
    computed: {
      policy () {
        const policies = this.$store.state.policies
        console.log('policies', policies)
        return this.$store.state.policies.find(p => p.name === this.policyName)
      },
      computedPolicy () {
        console.log('caclulating', this.policy)
        const header = this.policyHeaderTemplate
        const footer = this.policyFooterTemplate
        // const tableGrants = 'blah'
        const tableGrants = Object.keys(this.policy.roleGrants).reduce(
          (all, roleName) => {
            // console.log(roleGrants, roleGrants.roleName, roleGrants)
            const roleGrantSet = this.policy.roleGrants[roleName]
            return all.concat(Object.keys(roleGrantSet)
              .filter(f => f !== 'roleName')
              .reduce(
                (all, action) => {
                  return roleGrantSet[action] ?
                    all.concat(`${roleName}\n`) :
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

        return !this.enableRls ? hdrs : hdrs.concat([{
            text: 'Rls Qualifier',
            sortable: false
          }])
      },
    },
  }
</script>