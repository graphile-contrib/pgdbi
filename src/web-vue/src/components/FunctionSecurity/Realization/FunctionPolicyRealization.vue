<template>
  <v-container>
    <script-viewer
      :scriptText="computedPolicy"
      @readability-changed="policyReadabilityChanged"
      skipFormat
    ></script-viewer>
  </v-container>
</template>

<script>
  import PolicyComputerMixin from '@/components/FunctionSecurity/Realization/FunctionPolicyComputerMixin'
  import ScriptViewer from '@/components/_common/ScriptViewer'
  import VueClipboard from 'vue-clipboard2'

  export default {
    name: 'FunctionDefinition',
    mixins: [
      PolicyComputerMixin,
      VueClipboard
    ],
    components: {
      ScriptViewer
    },
    props: {
      policyDefinition: {
        type: Object,
        required: true
      },
      aFunction: {
        type: Object,
        required: false
      }
    },
    data () {
      return {
        policyStructure: [],
        policyReadability: 'terse',
        computedPolicy: 'N/A'
      }
    },
    mounted () {
      this.doComputePolicy()
    },
    watch: {
      policyDefinition () {
        this.doComputePolicy()
      },
      policyReadability () {
        this.doComputePolicy()
      }
    },
    methods: {
      policyReadabilityChanged (policyReadability) {
        this.policyReadability = policyReadability
      },
      refresh () {
        this.doComputePolicy()
      },
      expand () {
        this.computedPolicy = `${this.computedPolicy} `
      },
      doComputePolicy () {
        const variables = this.aFunction ? {
        } : null
        this.computedPolicy = this.computePolicy(this.policyDefinition, this.policyReadability, variables, this.aFunction)
      },
      onCopy: function (e) {
        alert('Copied!')
      },
      onError: function (e) {
        alert('Failed to copy texts')
      },
      executeSql () {
        alert ('not implemented:  server config value will expose graphile extension to execute generated script')
      }
    },
    computed: {
    }
  }
</script>