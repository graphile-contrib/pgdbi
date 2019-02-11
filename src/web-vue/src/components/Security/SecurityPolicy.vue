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

  export default {
    name: 'SecurityPolicy',
    components: {
    },
    props: {
    },
    computed: {
      schemaFilter () {
        return this.$store.state.schemaFilter
      },
      policyTemplateNoRls () {
        return this.$store.state.policyTemplateNoRls
      },
      policyTemplateRls () {
        return this.$store.state.policyTemplateRls
      },
      appTenantFieldName () {
        return this.$store.state.appTenantFieldName
      }
      
    },
    methods: {
      calcOnePolicy (tables, policyTemplate) {
        return tables.reduce(
          (policy, table) => {
            const tablePolicy = policyTemplate.split('{{schemaName}}').join(table.tableSchema).split('{{tableName}}').join(table.name)
            return policy.concat(tablePolicy)
          }, ''
        )
      },
      calculateAllPolicies () {
        if (!this.schemaTree) {
          this.allPolicies = []
        } else {
          const schemaNames = this.schemaFilter.map(s => s.split(':')[1])

          this.allPolicies = schemaNames.reduce(
            (all, schemaName) => {
              const tablesInNeedOfRls = this.schemaTree.find(s => s.schemaName === schemaName).schemaTables
                .filter(t => t.tableColumns.find(c => c.columnName === this.appTenantFieldName) !== undefined)

              const withRls = {
                name: `${schemaName} - rls`,
                policy: this.calcOnePolicy(tablesInNeedOfRls, this.policyTemplateRls)
              }

              const tablesNotInNeedOfRls = this.schemaTree.find(s => s.schemaName === schemaName).schemaTables
                .filter(t => t.tableColumns.find(c => c.columnName === this.appTenantFieldName) === undefined)

              const withoutRls = {
                name: `${schemaName} - no rls`,
                policy: this.calcOnePolicy(tablesNotInNeedOfRls, this.policyTemplateNoRls)
              }

              return all.concat([withRls, withoutRls])
            }, []
          )
        }
      }
    },
    watch: {
      schemaFilter () {
        this.$apollo.queries.init.refetch()
      }
    },
    data: () => ({
      allPolicies: [],
      schemaPolicy: 'NOT CALCULATED',
      defaultRlsPolicies: 'NOT CALCULATED',
      defaultNoRlsPolicies: 'NOT CALCULATED',
      selectedTabName: ''
    }),
    apollo: {
      init: {
        query () {
          return getDbSchemaTree
        },
        fetchPolicy: 'network-only',
        update (result) {
          this.schemaTree = result.allSchemata.nodes
          this.calculateAllPolicies()
        }
      }
    }
  }
</script>

<style>

</style>
