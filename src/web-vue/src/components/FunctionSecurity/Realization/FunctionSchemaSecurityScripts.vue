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
          <v-layout
            align-center
            align-content-center
            justify-center
            justify-content-center
          >
            <v-tooltip bottom>
              <template v-slot:activator="{ on }">
                <v-btn @click="refresh" v-on="on"><v-icon>note_add</v-icon>Refresh</v-btn>
              </template>
              <span>Refresh</span>
            </v-tooltip>
            <v-tooltip bottom>
              <template v-slot:activator="{ on }">
                <v-btn @click="expand(schemaPolicy)" v-on="on"><v-icon>note_add</v-icon>Expand</v-btn>
              </template>
              <span>Expand</span>
            </v-tooltip>
            <v-tooltip bottom>
              <template v-slot:activator="{ on }">
                <v-btn 
                  v-on="on" 
                  v-clipboard:copy="policyText(schemaPolicy)"
                  v-clipboard:success="onCopy"
                  v-clipboard:error="onError"
                ><v-icon>file_copy</v-icon>Copy
              </v-btn>
              </template>
              <span>Copy</span>
            </v-tooltip>
            <v-tooltip bottom>
              <template v-slot:activator="{ on }">
                <v-btn v-on="on" @click="executeSql"><v-icon>arrow_forward</v-icon>Execute</v-btn>
              </template>
              <span>Execute</span>
            </v-tooltip>
            <v-spacer></v-spacer>
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
          </v-layout>
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
  import PolicyComputerMixin from '@/components/FunctionSecurity/Realization/FunctionPolicyComputerMixin'
  import { mapState } from 'vuex'

  export default {
    name: 'SchemaSecurityScripts',
    mixins: [
      PolicyComputerMixin
    ],
    components: {
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
      refresh () {
        this.doComputePolicy()
      },
      expand () {
        this.computedPolicy = `${this.computedPolicy} `
      },
      calcOnePolicy (someFunctions) {
        const retval = someFunctions.sort((a,b)=>{return a.functionname < b.functionname ? -1 : 1}).reduce(
          (policy, aFunction) => {
            const policyTemplate = this.functionPolicies.find(p => p.id === aFunction.functionPolicyDefinitionId)
            const variables = {
              schemaName: aFunction.functionSchema,
              functionName: aFunction.functionName
            }
            const aFunctionPolicy = this.computePolicy(policyTemplate, this.policyReadability, variables)
            return policy.concat(aFunctionPolicy)
          }, ''
        )
        return retval

      },
      calculateAllPolicies () {
        this.allPolicies = this.managedSchemata
          .filter(s => !s.parked)
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
