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
          @readability-changed="policyReadabilityChanged"
          skipFormat
          canExecute
        ></script-viewer>
      </v-tab-item>
    </v-tabs>

  </v-container>
</template>

<script>
  import ScriptViewer from '@/components/_common/ScriptViewer'
  import { mapState } from 'vuex'
  import computeAllSchemaTablePolicies from '@/scriptCompute/computeAllSchemaTablePolicies'
  import computeMasterTablePolicy from '@/scriptCompute/computeMasterTablePolicy'
  
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
      ...mapState(['policies', 'managedSchemata'])
    },
    watch: {
      policyReadability () {
        this.computeAllPolicies()
      },
    },
    methods: {
      computeAllPolicies () {
        const mostPolicies = computeAllSchemaTablePolicies(this.$store.state, this.policyReadability)
        const masterPolicy = computeMasterTablePolicy(this.$store.state, this.policyReadability)
        this.allPolicies = [...mostPolicies, masterPolicy]
      },
      policyReadabilityChanged (policyReadability) {
        this.policyReadability = policyReadability
      },
      handleCopyStatus(status) {
        alert(status)
      },
      refresh(schemaPolicy) {
        this.computeAllPolicies()
      },
      expand (schemaPolicy) {
        schemaPolicy.policy = `${schemaPolicy.policy} `
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
