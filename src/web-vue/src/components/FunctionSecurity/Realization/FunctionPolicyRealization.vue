<template>
  <v-container>
    <script-viewer
      :scriptText="computedPolicy"
      @readability-changed="policyReadabilityChanged"
      skipFormat
      canExecute
    ></script-viewer>
  </v-container>
</template>

<script>
  import ScriptViewer from '@/components/_common/ScriptViewer'
  import VueClipboard from 'vue-clipboard2'
  import computeFunctionPolicy from '@/scriptCompute/computeFunctionPolicy'

  export default {
    name: 'FunctionDefinition',
    mixins: [
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
        this.computedPolicy = computeFunctionPolicy(this.policyDefinition, this.policyReadability, variables, this.aFunction)
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