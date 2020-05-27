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
        <script-viewer
          :scriptText="schemaPolicy.policy"
          @readability-changed="readabilityChanged"
          skipFormat
        ></script-viewer>
      </v-tab-item>
    </v-tabs>

  </v-container>
</template>

<script>
  import ScriptViewer from '@/components/_common/ScriptViewer'
  import { mapState } from 'vuex'
  import computeFunctionPolicy from '@/scriptCompute/computeFunctionPolicy'

  export default {
    name: 'SchemaSecurityScripts',
    mixins: [
    ],
    components: {
      ScriptViewer
    },
    props: {
    },
    computed: {
      ...mapState(['functionPolicies', 'managedSchemata']),
    },
    watch: {
      functionPolicies () {
        this.calculateAllPolicies()
      },
      policyReadability () {
        this.calculateAllPolicies()
      },
    },
    methods: {
      readabilityChanged (readability) {
        this.policyReadability = readability
      },
      refresh () {
        this.doComputePolicy()
      },
      expand () {
        this.computedPolicy = `${this.computedPolicy} `
      },
      calcOnePolicy (someFunctions) {
        const retval = someFunctions.sort((a,b)=>{return a.functionname < b.functionname ? -1 : 1}).reduce(
          (policy, aFunction) => {
            const policyTemplate = this.functionPolicies.find(p => p.id === this.$store.state.functionPolicyAssignments[aFunction.id].policyDefinitionId)
            const variables = {
            }
            const aFunctionPolicy = computeFunctionPolicy(policyTemplate, this.policyReadability, variables, aFunction)
            return policy.concat(aFunctionPolicy)
          }, ''
        )
        return retval

      },
      calculateAllPolicies () {
        const masterPolicyName = 'One Script To Rule Them All'
        const mostPolicies = this.managedSchemata
          .filter(s => !s.parked)
          .filter(s => s.schemaFunctions.length > 0)
          .reduce(
            (all, schema) => {
              const schemaFunctions = schema.schemaFunctions
              const schemaPolicy = {
                name: `${schema.schemaName}`,
                policy: this.calcOnePolicy(schemaFunctions)
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
