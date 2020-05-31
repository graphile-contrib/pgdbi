<template>
  <v-container>
    <script-viewer
      :scriptText="computeOwnershipPolicy"
      @readability-changed="readabilityChanged"
      skipFormat
      canExecute
    ></script-viewer>
  </v-container>
</template>

<script>
  import { mapState } from 'vuex'
  import ScriptViewer from '@/components/_common/ScriptViewer'
  import computeOwnershipPolicy from '@/scriptCompute/computeOwnershipPolicy'

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
        this.computeOwnershipPolicy = computeOwnershipPolicy(this.$store.state, this.policyReadability)
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
      }
    },
    data: () => ({
      computeOwnershipPolicy: 'N/A',
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
