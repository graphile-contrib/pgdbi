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
        <v-toolbar>
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn @click="expand(schemaPolicy)" v-on="on"><v-icon>note_add</v-icon></v-btn>
            </template>
            <span>Expand</span>
          </v-tooltip>
          <!-- <v-btn @click="expand(schemaPolicy)">Expand</v-btn> -->
          <button 
            v-clipboard:copy="schemaPolicy.policy"
          >Copy</button>
        </v-toolbar>
        <v-textarea
          :disabled="true"
          :value="schemaPolicy.policy"
          auto-grow
          spellcheck="false"
          background-color="black"
        ></v-textarea>
      </v-tab-item>
    </v-tabs>

  </v-container>
</template>

<script>
  import PolicyComputerMixin from '../Policy/PolicyComputerMixin'
  import getDbSchemaTree from '@/gql/query/getDbSchemaTree.graphql'
  import { mapState } from 'vuex'

  export default {
    name: 'SecurityPolicy',
    mixins: [
      PolicyComputerMixin
    ],
    components: {
    },
    props: {
    },
    computed: {
      ...mapState(['policies']),
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
      handleCopyStatus(status) {
        alert(status)
      },
      expand (schemaPolicy) {
        schemaPolicy.policy = `${schemaPolicy.policy} `
      },
      findTablePolicyTemplate (tableName) {
        return this.policies.find(p => p.name === 'Default Policy')
      },
      calcOnePolicy (tables) {
        return tables.reduce(
          (policy, table) => {
            const policyTemplate = this.findTablePolicyTemplate(table.name)
            const tablePolicy = this.computePolicy(policyTemplate, 'terse')
            return policy.concat(tablePolicy).split('{{schemaName}}').join(table.tableSchema).split('{{tableName}}').join(table.name)
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
              const tables = this.schemaTree.find(s => s.schemaName === schemaName).schemaTables

              const schemaPolicy = {
                name: `${schemaName}`,
                policy: this.calcOnePolicy(tables)
              }
              return all.concat([schemaPolicy])
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
