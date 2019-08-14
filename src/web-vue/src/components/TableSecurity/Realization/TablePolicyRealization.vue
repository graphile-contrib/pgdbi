<template>
  <v-container>
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
            <v-btn @click="expand" v-on="on"><v-icon>note_add</v-icon>Expand</v-btn>
          </template>
          <span>Expand</span>
        </v-tooltip>
        <v-tooltip bottom>
          <template v-slot:activator="{ on }">
            <v-btn 
              v-on="on" 
              :hidden="!table"
              v-clipboard:copy="computedPolicy"
              v-clipboard:success="onCopy"
              v-clipboard:error="onError"
            ><v-icon>file_copy</v-icon>Copy
          </v-btn>
          </template>
          <span>Copy</span>
        </v-tooltip>
        <v-tooltip bottom>
          <template v-slot:activator="{ on }">
            <v-btn v-on="on" :hidden="!table" @click="executeSql"><v-icon>arrow_forward</v-icon>Execute</v-btn>
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
      :value="computedPolicy"
      auto-grow
      hide-details
      background-color="black"
      disabled
    >
    </v-textarea>
  </v-container>
</template>

<script>
  import PolicyComputerMixin from './TablePolicyComputerMixin'
  import VueClipboard from 'vue-clipboard2'

  export default {
    name: 'PolicyDefinition',
    mixins: [
      PolicyComputerMixin,
      VueClipboard
    ],
    components: {
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