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
        lazy
      >
        <script-viewer
          :scriptText="schemaPolicy.policy"
          @readability-changed="policyReadabilityChanged"
          skipFormat
        ></script-viewer>
      </v-tab-item>
    </v-tabs>

  </v-container>
</template>

<script>
  import PolicyComputerMixin from './TablePolicyComputerMixin'
  import ScriptViewer from '@/components/_common/ScriptViewer'
  import { mapState } from 'vuex'

  export default {
    name: 'SchemaSecurityScripts',
    mixins: [
      PolicyComputerMixin
    ],
    components: {
      ScriptViewer
    },
    props: {
    },
    computed: {
      ...mapState(['policies', 'managedSchemata']),
    },
    watch: {
      policyReadability () {
        this.calculateAllPolicies()
      },
    },
    methods: {
      policyReadabilityChanged (policyReadability) {
        this.policyReadability = policyReadability
      },
      handleCopyStatus(status) {
        alert(status)
      },
      refresh(schemaPolicy) {
        this.calculateAllPolicies()
      },
      expand (schemaPolicy) {
        schemaPolicy.policy = `${schemaPolicy.policy} `
      },
      calcOnePolicy (tables) {
        return tables.sort((a,b)=>{return a.tablename < b.tablename ? -1 : 1}).reduce(
          (policy, table) => {
            const policyTemplate = this.policies.find(p => p.id === this.$store.state.tablePolicyAssignments[table.id].policyDefinitionId)
            const variables = {
              schemaName: table.tableSchema,
              tableName: table.tablename
            }
            const tablePolicy = this.computePolicy(policyTemplate, this.policyReadability, variables, table)
            return policy.concat(tablePolicy)
          }, ''
        )
      },
      calculateAllPolicies () {
        const masterPolicyName = 'One Script To Rule Them All'
        const mostPolicies = this.managedSchemata
          .filter(s => !s.parked)
          .reduce(
            (all, schema) => {
              const schemaTables = schema.schemaTables.filter(t => t.tableType === 'BASE TABLE')
              const schemaPolicy = {
                name: `${schema.schemaName}`,
                policy: this.calcOnePolicy(schemaTables)
              }
              return all.concat([schemaPolicy])
            }, []
          )
          .sort(
            (a,b)=>{ 
              return a.name < b.name ? -1 : 1
            }
          )

        const masterPolicy = mostPolicies.reduce(
          (m, p) => {
            return m.concat(p.policy)
          }, ''
        )

        this.allPolicies = [
          ...mostPolicies,
          {
            name: masterPolicyName,
            policy: masterPolicy
          }
        ]
      },
      policyText (schemaPolicy) {
        return schemaPolicy.policy
      },
      onCopy: function () {
        alert('Copied!')
      },
      onError: function (e) {
        alert('Failed to copy scripts to clipboard')
        console.error(e)
      },
      executeSql () {
        alert ('not implemented:  server config value will expose graphile extension to execute generated script')
      }
    },
    data: () => ({
      allPolicies: [],
      schemaPolicy: 'NOT CALCULATED',
      defaultRlsPolicies: 'NOT CALCULATED',
      defaultNoRlsPolicies: 'NOT CALCULATED',
      selectedTabName: '',
      policyReadability: 'terse'

    }),
    mounted () {
      this.calculateAllPolicies()
    }
  }
</script>

<style>

</style>
