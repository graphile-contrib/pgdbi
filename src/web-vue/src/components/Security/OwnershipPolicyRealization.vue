<template>
  <v-container>
    <script-viewer
      :scriptText="ownerhipSecurityPolicy"
      @readability-changed="readabilityChanged"
      skipFormat
    ></script-viewer>
  </v-container>
</template>

<script>
  import { mapState } from 'vuex'
  import ScriptViewer from '@/components/_common/ScriptViewer'
  import computeOwnerhipSecurityPolicy from '@/scriptCompute/computeOwnerhipSecurityPolicy'

  export default {
    name: 'OwnershipPolicyRealization',
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
        this.ownerhipSecurityPolicy = computeOwnerhipSecurityPolicy(this.$store.state, this.policyReadability)
        console.log('master', this.ownerhipSecurityPolicy)
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
      ownerhipSecurityPolicy: 'N/A',
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
