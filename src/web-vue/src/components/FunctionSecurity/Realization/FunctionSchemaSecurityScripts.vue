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
          canExecute
        ></script-viewer>
      </v-tab-item>
    </v-tabs>

  </v-container>
</template>

<script>
  import { mapState } from 'vuex'
  import ScriptViewer from '@/components/_common/ScriptViewer'
  import computeAllSchemaFunctionPolicies from '@/scriptCompute/computeAllSchemaFunctionPolicies'
  import computeMasterFunctionPolicy from '@/scriptCompute/computeMasterFunctionPolicy'

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
        this.computeAllPolicies()
      },
      policyReadability () {
        this.computeAllPolicies()
      },
    },
    methods: {
      computeAllPolicies () {
        const mostPolicies = computeAllSchemaFunctionPolicies(this.$store.state, this.policyReadability)
        const masterPolicy = computeMasterFunctionPolicy(this.$store.state, this.policyReadability)
        this.allPolicies = [...mostPolicies, masterPolicy]
      },
      readabilityChanged (readability) {
        this.policyReadability = readability
      },
      refresh () {
        this.doComputePolicy()
      },
      expand () {
        this.computedPolicy = `${this.computedPolicy} `
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
      this.computeAllPolicies()
    }
  }
</script>

<style>

</style>
