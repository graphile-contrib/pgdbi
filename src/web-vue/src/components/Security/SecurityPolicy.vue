<template>
  <v-container>
    <v-tabs
      dark
      slider-color="yellow"
    >
      <v-tab
        v-for="schemaPolicy in allPolicies"
        :key="schemaPolicy.name"
        ripple
      >
        {{ schemaPolicy.name }}
      </v-tab>
      <v-tab-item
        v-for="schemaPolicy in allPolicies"
        :key="schemaPolicy.name"
      >
        <v-textarea
          :value="schemaPolicy.policy"
          auto-grow
          spellcheck="false"
        ></v-textarea>
      </v-tab-item>
    </v-tabs>

  </v-container>
</template>

<script>
  import getDbSchemaTree from '@/gql/query/getDbSchemaTree.graphql'
  import generatePolicyWithDefaultRLS from './generatePolicyWithDefaultRLS.js'
  import generatePolicyWithDefaultNoRLS from './generatePolicyWithDefaultNoRLS.js'

  export default {
    name: 'SecurityPolicy',
    components: {
    },
    props: {
    },
    computed: {
      schemaFilter () {
        return this.$store.state.schemaFilter
      }
    },
    methods: {
      calcOnePolicy (schemaName, superAdminRole, userRole, appTenantIdField) {
        const tables = this.schemaTree.find(s => s.schemaName === schemaName).schemaTables
          .filter(t => t.tableColumns.find(c => c.columnName === 'seller_id') !== undefined)

        const policyReducer = appTenantIdField !== null && appTenantIdField !== undefined ? this.generatePolicyWithDefaultRLS : this.generatePolicyWithDefaultNoRLS

        return tables.reduce(
          (policy, table) => {
            const tablePolicy = policyReducer(table.tableSchema, table.name, userRole, superAdminRole, appTenantIdField)
            return policy.concat(tablePolicy)
          }, ''
        )
      },
      calculatePolicy () {
        this.defaultRLSPolicies = this.calcOnePolicy('soro', 'soro_super_admin', 'soro_user', 'seller_id')        
        this.defaultNoRLSPolicies = this.calcOnePolicy('soro', 'soro_super_admin', 'soro_user')
      },
      generatePolicyWithDefaultRLS: generatePolicyWithDefaultRLS,
      generatePolicyWithDefaultNoRLS: generatePolicyWithDefaultNoRLS,
      calculateAllPolicies () {
        if (!this.schemaTree) {
          this.allPolicies = []
        } else {
          const schemaNames = this.schemaFilter.map(s => s.split(':')[1])

          this.allPolicies = schemaNames.reduce(
            (all, schemaName) => {
              const withRLS = {
                name: `${schemaName} - rls`,
                policy: this.calcOnePolicy(schemaName,'soro_super_admin', 'soro_user', 'seller_id')
              }
              const withoutRLS = {
                name: `${schemaName} - no rls`,
                policy: this.calcOnePolicy(schemaName,'soro_super_admin', 'soro_user')
              }

              return all.concat([withRLS, withoutRLS])
            }, []
          )
        }
      }
    },
    data: () => ({
      allPolicies: [],
      schemaPolicy: 'NOT CALCULATED',
      defaultRLSPolicies: 'NOT CALCULATED',
      defaultNoRLSPolicies: 'NOT CALCULATED',
      selectedTabName: ''
    }),
    apollo: {
      init: {
        query () {
          return getDbSchemaTree
        },
        update (result) {
          this.schemaTree = result.allSchemata.nodes
          this.calculateAllPolicies()
        }
      }
    }
    // created () {
    //   this.getDbSchemaTree()
    // }
  }
</script>

<style>

</style>
