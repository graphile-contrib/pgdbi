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
            <v-btn @click="expand" v-on="on"><v-icon>note_add</v-icon></v-btn>
          </template>
          <span>Expand</span>
        </v-tooltip>
        <v-tooltip bottom>
          <template v-slot:activator="{ on }">
            <v-btn 
              v-on="on" 
              :hidden="!theFunction"
              v-clipboard:copy="computedPolicy"
              v-clipboard:success="onCopy"
              v-clipboard:error="onError"
            ><v-icon>file_copy</v-icon>
          </v-btn>
          </template>
          <span>Copy</span>
        </v-tooltip>
        <v-tooltip bottom>
          <template v-slot:activator="{ on }">
            <v-btn v-on="on" :hidden="!theFunction" @click="executeSql"><v-icon>arrow_forward</v-icon></v-btn>
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
  import PolicyComputerMixin from './FunctionPolicyComputerMixin'
  import VueClipboard from 'vue-clipboard2'

  export default {
    name: 'FunctionDefinition',
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
      theFunction: {
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
      expand () {
        this.computedPolicy = `${this.computedPolicy}=`
      },
      doComputePolicy () {
        const variables = this.theFunction ? {
          schemaName: this.theFunction.functionSchema,
          functionName: this.theFunction.name
        } : null
        this.computedPolicy = this.computePolicy(this.policyDefinition, this.policyReadability, variables)
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