<template>
    <div :key="policy.id">
      <h1>Policy Name: {{ policy.name }}</h1>
      <v-layout justify-center>
        <v-checkbox v-model="enableRls" label="Enable Rls"></v-checkbox>
      </v-layout>
      <v-tabs
        v-model="activeTab"
        dark
      >
        <v-tab
          key="grants"
          ripple
        >
          Table Grants
        </v-tab>
        <v-tab-item
          key="grants"
        >
          <v-card flat>
          <policy-definition-grant-grid
            :policy="policy"
          ></policy-definition-grant-grid>
          </v-card>
        </v-tab-item>

        <v-tab
          key="rls"
          ripple
          :disabled="!enableRls"
        >
          Row Level Security
        </v-tab>
        <v-tab-item
          key="rls"
        >
          <v-card flat>
          <policy-rls-qualifier-grid
            :policy="policy"
          ></policy-rls-qualifier-grid>
          </v-card>
        </v-tab-item>

      </v-tabs>
      <v-toolbar>
        <v-btn @click="expand">Expand</v-btn>
        <v-radio-group v-model="policyReadability" row>
          <v-radio
            key="terse"
            label="Terse"
            value="terse"
          ></v-radio>
          <v-radio
            key="verbose"
            label="Verbose"
            value="verbose"
          ></v-radio>
        </v-radio-group>
        <!-- <button 
          v-clipboard:copy="computedPolicy"
        >Copy</button> -->
      </v-toolbar>
      <v-textarea
        :value="computedPolicy"
        auto-grow
        hide-details
      >
      </v-textarea>
    </div>
</template>

<script>
  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'

  import PolicyDefinitionGrantGrid from './PolicyDefinitionGrantGrid.vue'
  import PolicyRlsQualifierGrid from './PolicyRlsQualifierGrid.vue'

  export default {
    name: 'PolicyDefinition',
    components: {
      PolicyDefinitionGrantGrid,
      PolicyRlsQualifierGrid
    },
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
        toggleCompleted: false,
        activeTab: '',
        policyReadability: 'verbose'
      }
    },
    watch: {
      policyReadability () {
        console.log('policyReadability', this.policyReadability)
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
        return [ALLOWED, IMPLIED].indexOf(roleGrant[action]) > -1
      },
      roleGrantDisabled(roleGrant, action) {
        // return false;
        return roleGrant[action] === IMPLIED
      },
      roleIsApplicable(role, applicableRole) {

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

        // remove all existing table grants
        const securityRemoval =`
-------------- REMOVE EXISTING TABLE GRANTS ----------------------

revoke all privileges on table {{schemaName}}.{{tableName}} from public;
`.concat(Object.keys(this.policy.roleGrants).reduce(
            (all, roleName) => {
              return all.concat(`revoke all privileges on table {{schemaName}}.{{tableName}} from ${roleName};\n`)
            }, ''
          )
        )
//   alter table {{schemaName}}.{{tableName}} disable row level security;
//   --  END REMOVE ALL SECURITY
// `

        // table grants
        const tableGrants = `
-------------- CREATE NEW TABLE GRANTS ----------------------

`.concat(Object.keys(this.policy.roleGrants).reduce(
            (all, roleName) => {
              const roleGrantSet = this.policy.roleGrants[roleName]

              return all
                .concat(this.policyReadability === 'terse' ? `` : `---------------------------------------------------------------------------------------------------------------------------------------${roleName}\n`)
                .concat(Object.keys(roleGrantSet)
                .filter(f => f !== 'roleName')
                .reduce(
                  (all, action) => {
                    const allInEffect = [ALLOWED, IMPLIED].indexOf(this.policy.roleGrants[roleName].all) > -1
                    if (roleGrantSet[action] === ALLOWED) {
                      if (allInEffect) {
                        return action === 'all' 
                          ? all.concat(`grant ${action} on table {{schemaName}}.{{tableName}} to ${roleName};\n`) 
                          : this.policyReadability === 'terse'
                            ? all
                            : all.concat(`-- IMPLIED:  ${action} on table {{schemaName}}.{{tableName}} to ${roleName}\n`)
                      } else {
                        return all.concat(`grant ${action} on table {{schemaName}}.{{tableName}} to ${roleName};\n`)
                      }
                    } else if (roleGrantSet[action] === IMPLIED) {
                      return this.policyReadability === 'terse' ? all : all.concat(`-- IMPLIED:  ${action} on table {{schemaName}}.{{tableName}} to ${roleName}\n`)
                    } else if (roleGrantSet[action] === DENIED) {
                      return this.policyReadability === 'terse' ? all : all.concat(`-- DENIED:   ${action} on table {{schemaName}}.{{tableName}} to ${roleName}\n`)
                    }
                  }, ''
                ))
              }, ''
          )
        )

        // rls
        const rlsSection = !this.enableRls ? `
-------------- DISABLE ROW LEVEL SECURITY ----------------------

alter table {{schemaName}}.{{tableName}} disable row level security;
` : `
-------------- ENABLE ROW LEVEL SECURITY ----------------------

alter table {{schemaName}}.{{tableName}} enable row level security;
`

        return header.concat(securityRemoval).concat(tableGrants).concat(rlsSection).concat(footer)
      },
      // grantMatrix () {
      //   return Object.keys(this.policy.roleGrants).map(
      //     roleName => {
      //       return {
      //         ...this.policy.roleGrants[roleName]
      //         ,roleName: roleName
      //       }
      //     }
      //   )
      // },
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