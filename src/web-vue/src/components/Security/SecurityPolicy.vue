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
          <v-btn @click="calculateAllPolicies">Refresh</v-btn>
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
      ...mapState(['policies', 'managedSchemata']),
    },
    watch: {
      policies () {
        this.calculateAllPolicies()
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
        return tables.sort((a,b)=>{return a.name < b.name ? -1 : 1}).reduce(
          (policy, table) => {
            const policyTemplate = this.policies.find(p => p.id === table.policyDefinitionId)
            console.log('tt', policyTemplate.id, table.name, policyTemplate.name, policyTemplate, this.policies)
            const tablePolicy = this.computePolicy(policyTemplate, 'terse')
            return policy.concat(tablePolicy).split('{{schemaName}}').join(table.tableSchema).split('{{tableName}}').join(table.name)
          }, ''
        )
      },
      calculateAllPolicies () {
          this.allPolicies = this.managedSchemata
            .filter(s => !s.parked)
            .reduce(
              (all, schema) => {
                const tables = schema.schemaTables
                const schemaPolicy = {
                  name: `${schema.schemaName}`,
                  policy: this.calcOnePolicy(tables)
                }
                return all.concat([schemaPolicy])
              }, []
            )
          }
    },
    data: () => ({
      allPolicies: [],
      schemaPolicy: 'NOT CALCULATED',
      defaultRlsPolicies: 'NOT CALCULATED',
      defaultNoRlsPolicies: 'NOT CALCULATED',
      selectedTabName: ''
    }),
    mounted () {
      this.calculateAllPolicies()
    }
  }
</script>

<style>

</style>
