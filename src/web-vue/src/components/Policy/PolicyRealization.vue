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
            <v-btn v-on="on"><v-icon>file_copy</v-icon></v-btn>
          </template>
          <span>Copy</span>
        </v-tooltip>
        <v-tooltip bottom>
          <template v-slot:activator="{ on }">
            <v-btn v-on="on" :hidden="!table"><v-icon>arrow_forward</v-icon></v-btn>
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
  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'

  import PolicyComputerMixin from './PolicyComputerMixin'

  export default {
    name: 'PolicyDefinition',
    mixins: [
      PolicyComputerMixin
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
      }
    },
    data () {
      return {
        policyStructure: [],
        calculatedPolicy: 'NOT CALCULATED',
        toggleCompleted: false,
        activeTab: '',
        policyReadability: 'terse',
        computedPolicy: 'N/A'
      }
    },
    mounted () {
      this.enableRls = this.policyDefinition.enableRls
      this.doComputePolicy()
    },
    watch: {
      policyReadability () {
        this.doComputePolicy()
      },
    },
    methods: {
      expand () {
        this.computedPolicy = `${this.computedPolicy}=`
      },
      doComputePolicy () {
        const variables = this.table ? {
          schemaName: this.table.tableSchema,
          tableName: this.table.name
        } : null
        this.computedPolicy = this.computePolicy(this.policyDefinition, this.policyReadability, variables)
      },
    },
    computed: {
    }
  }
</script>