<template>
  <v-container>
    <v-tabs
      dark
      slider-color="yellow"
    >
      <v-tab
        v-for="schemaPolicy in allPolicies"
        :key="schemaPolicy.name"
        ripple
      >
        {{ schemaPolicy.name }}
      </v-tab>
      <v-tab-item
        v-for="schemaPolicy in allPolicies"
        :key="schemaPolicy.name"
        lazy
      >
        <v-toolbar>
        <v-tooltip bottom>
          <template v-slot:activator="{ on }">
            <v-btn @click="refresh(schemaPolicy)" v-on="on"><v-icon>note_add</v-icon>Refresh</v-btn>
          </template>
          <span>Refresh</span>
        </v-tooltip>
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn @click="expand(schemaPolicy)" v-on="on"><v-icon>note_add</v-icon>Expand</v-btn>
            </template>
            <span>Expand</span>
          </v-tooltip>
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn 
                v-on="on" 
                v-clipboard:copy="policyText(schemaPolicy)"
                v-clipboard:success="onCopy"
                v-clipboard:error="onError"
              ><v-icon>file_copy</v-icon>Copy
            </v-btn>
            </template>
            <span>Copy</span>
          </v-tooltip>
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn v-on="on" @click="executeSql"><v-icon>arrow_forward</v-icon>Execute</v-btn>
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
        </v-toolbar>
        <v-textarea
          :disabled="true"
          :value="schemaPolicy.policy"
          auto-grow
          spellcheck="false"
          background-color="black"
        ></v-textarea>
      </v-tab-item>
    </v-tabs>

  </v-container>
</template>

<script>
  import PolicyComputerMixin from './TablePolicyComputerMixin'
  import { mapState } from 'vuex'

  export default {
    name: 'SchemaSecurityScripts',
    mixins: [
      PolicyComputerMixin
    ],
    components: {
    },
    props: {
    },
    computed: {
      ...mapState(['policies', 'managedSchemata']),
    },
    watch: {
      // policies () {
      //   this.calculateAllPolicies()
      // },
      // policyReadability () {
      //   this.calculateAllPolicies()
      // },
    },
    methods: {
      handleCopyStatus(status) {
        alert(status)
      },
      refresh(schemaPolicy) {
        this.calculateAllPolicies()
      },
      expand (schemaPolicy) {
        schemaPolicy.policy = `${schemaPolicy.policy} `
      },
      calcOnePolicy (tables) {
        return tables.sort((a,b)=>{return a.tablename < b.tablename ? -1 : 1}).reduce(
          (policy, table) => {
            const policyTemplate = this.policies.find(p => p.id === table.policyDefinitionId)
            const variables = {
              schemaName: table.tableSchema,
              tableName: table.tablename
            }
            const tablePolicy = this.computePolicy(policyTemplate, this.policyReadability, variables, table)
            return policy.concat(tablePolicy)
          }, ''
        )
      },
      calculateAllPolicies () {
        this.allPolicies = this.managedSchemata
          .filter(s => !s.parked)
          .reduce(
            (all, schema) => {
              const tables = schema.schemaTables
              const schemaPolicy = {
                name: `${schema.schemaName}`,
                policy: this.calcOnePolicy(tables)
              }
              return all.concat([schemaPolicy])
            }, []
          )
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
      allPolicies: [],
      schemaPolicy: 'NOT CALCULATED',
      defaultRlsPolicies: 'NOT CALCULATED',
      defaultNoRlsPolicies: 'NOT CALCULATED',
      selectedTabName: '',
      policyReadability: 'terse'

    }),
    mounted () {
      this.calculateAllPolicies()
    }
  }
</script>

<style>

</style>
