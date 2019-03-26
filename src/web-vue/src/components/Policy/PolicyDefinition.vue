<template>
    <v-card color="black" :key="policyDefinition.id">
      <v-container>
        <v-toolbar>
          <h1>Policy Name: {{ policyDefinition.name }}</h1>
          <v-spacer></v-spacer>
          <v-layout justify-center>
            <v-checkbox v-model="enableRls" label="Enable Rls" :disabled="disabled"></v-checkbox>
          </v-layout>
          <v-btn>Modify</v-btn>
        </v-toolbar>
        <v-tabs
          v-model="activeTab"
          dark
        >
          <v-tab
            key="grants"
            ripple
          >
            Table Grants
          </v-tab>
          <v-tab-item
            key="grants"
          >
            <v-card flat>
            <policy-definition-grant-grid
              :policy="policyDefinition"
              :disabled="disabled"
            ></policy-definition-grant-grid>
            </v-card>
          </v-tab-item>

          <v-tab
            key="rls"
            ripple
            :disabled="!enableRls"
          >
            Row Level Security
          </v-tab>
          <v-tab-item
            key="rls"
          >
            <v-card flat>
            <policy-rls-qualifier-grid
              :policy="policyDefinition"
              :disabled="disabled"
            ></policy-rls-qualifier-grid>
            </v-card>
          </v-tab-item>

          <v-tab
            key="policy-template"
            ripple
          >
            {{ table ? 'Policy' : 'Policy Template'}}
          </v-tab>
          <v-tab-item
            key="policy-template"
          >
            <v-card flat>
              <policy-realization
                :policyDefinition="policyDefinition"
                :table="table"
              ></policy-realization>
            </v-card>
          </v-tab-item>

        </v-tabs>
      </v-container>
    </v-card>
</template>

<script>
  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'

  import PolicyDefinitionGrantGrid from './PolicyDefinitionGrantGrid.vue'
  import PolicyRlsQualifierGrid from './PolicyRlsQualifierGrid.vue'
  import PolicyRealization from './PolicyRealization.vue'

  export default {
    name: 'PolicyDefinition',
    components: {
      PolicyDefinitionGrantGrid,
      PolicyRlsQualifierGrid,
      PolicyRealization
    },
    props: {
      policyId: {
        type: Number,
        required: true
      },
      table: {
        type: Object,
        required: false
      }
    },
    data () {
      return {
        enableRls: true,
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
      policy () {
        this.enableRls = this.policyDefinition.enableRls
        this.doComputePolicy()
      },
      enableRls () {
        this.$store.commit('savePolicy', {
          policy: {
            ...this.policyDefinition,
            enableRls: this.enableRls
          }
        })
      }
    },
    methods: {
      expand () {
        this.computedPolicy = `${this.computedPolicy}=`
      },
      // roleGrantSelected(roleGrant, action) {
      //   return [ALLOWED, IMPLIED].indexOf(roleGrant[action]) > -1
      // },
      // roleGrantDisabled(roleGrant, action) {
      //   return roleGrant[action] === IMPLIED
      // },
    },
    computed: {
      disabled () {
        return this.table !== null && this.table !== undefined
      },
      policyDefinition () {
        const policies = this.$store.state.policies
        const pol = this.$store.state.policies.find(p => p.id === this.policyId)
        return pol
      }
    }
  }
</script>