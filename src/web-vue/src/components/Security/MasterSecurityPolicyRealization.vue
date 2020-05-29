<template>
  <v-container>
    <script-viewer
      :scriptText="masterPolicy"
      @readability-changed="readabilityChanged"
      skipFormat
    ></script-viewer>
  </v-container>
</template>

<script>
  import { mapState } from 'vuex'
  import ScriptViewer from '@/components/_common/ScriptViewer'
  import computeMasterSecurityPolicy from '@/scriptCompute/computeMasterSecurityPolicy'

  export default {
    name: 'MasterSecurityPolicyRealization',
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
        this.computePolicy()
      },
      policyReadability () {
        this.computePolicy()
      },
    },
    methods: {
      computePolicy () {
        this.masterPolicy = computeMasterSecurityPolicy(this.$store.state, this.policyReadability)
        console.log('master', this.masterPolicy)
      },
      readabilityChanged (readability) {
        this.policyReadability = readability
      },
      refresh () {
        this.computePolicy()
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
      masterPolicy: 'N/A',
      schemaPolicy: 'NOT CALCULATED',
      defaultRlsPolicies: 'NOT CALCULATED',
      defaultNoRlsPolicies: 'NOT CALCULATED',
      selectedTabName: '',
      policyReadability: 'terse'
    }),
    mounted () {
      this.computePolicy()
    }
  }
</script>

<style>

</style>
