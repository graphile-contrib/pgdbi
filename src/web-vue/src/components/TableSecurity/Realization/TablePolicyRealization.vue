<template>
  <v-container>
    <script-viewer
      :scriptText="computedPolicy"
      @readability-changed="policyReadabilityChanged"
    ></script-viewer>
  </v-container>
</template>

<script>
  import PolicyComputerMixin from './TablePolicyComputerMixin'
  import ScriptViewer from '@/components/_common/ScriptViewer'
  import VueClipboard from 'vue-clipboard2'

  export default {
    name: 'PolicyDefinition',
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
      table: {
        type: Object,
        required: false
      },
      enableRls: {
        type: Boolean,
        required: true
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
      let variables = null
      if (this.table) {
        variables = {
          schemaName: this.table.tableSchema,
          tableName: this.table.tableName,
        }
      }
      this.computedPolicy = this.computePolicy(this.policyDefinition, this.policyReadability, variables, this.table)
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