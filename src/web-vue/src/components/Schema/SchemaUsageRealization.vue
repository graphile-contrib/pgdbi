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
  import ScriptViewer from '@/components/_common/ScriptViewer'
  import VueClipboard from 'vue-clipboard2'
  import computeSchemaUsageSql from '@/scriptCompute/computeSchemaUsageSql.js'

  export default {
    name: 'SchemaUsageRealization',
    mixins: [
      VueClipboard
    ],
    components: {
      ScriptViewer
    },
    props: {
    },
    data () {
      return {
        policyReadability: 'terse',
        computedPolicy: 'N/A'
      }
    },
    mounted () {
      this.doComputePolicy()
    },
    watch: {
      policyReadability () {
        this.doComputePolicy()
      },
      enableRls () {
        this.doComputePolicy()
      },
      policyDefinition () {
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
      this.computedPolicy = computeSchemaUsageSql(this.$store.state)
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