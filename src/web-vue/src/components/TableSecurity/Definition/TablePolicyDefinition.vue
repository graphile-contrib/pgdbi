<template>
    <v-card color="black" :key="policyDefinition.id">
      <v-container>
        <v-toolbar>
          <h1>Name: {{ policyDefinition.name }}</h1>
          <v-spacer></v-spacer>
          <v-layout justify-center>
            <v-checkbox v-model="enableRls" label="Enable Rls" :disabled="disabled"></v-checkbox>
          </v-layout>
          <!-- <v-btn @click="customize" :hidden="!table">customize</v-btn> -->
          <!-- <table-policy-customize-dialog
            v-if="showCustomizeButton"
            :currentPolicyDefinition="table.policyDefinition"
            :tables="[table]"
          ></table-policy-customize-dialog> -->
          <table-policy-make-global-dialog
            v-if="showMakeGlobalButton"
            :policyDefinition="policyDefinition"
          ></table-policy-make-global-dialog>
          <table-policy-delete-dialog
            v-if="showDeleteButton"
            :policyDefinition="policyDefinition"
          ></table-policy-delete-dialog>
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
            lazy
          >
            <v-card flat>
            <policy-definition-grant-grid
              :policyDefinition="policyDefinition"
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
            lazy
          >
            <v-card flat>
            <policy-rls-qualifier-grid
              :policy="policyDefinition"
              :disabled="disabled"
            ></policy-rls-qualifier-grid>
            </v-card>
          </v-tab-item>

          <v-tab
            key="policy-column-exclusions"
            ripple
            :disabled="disabled"
        >
            Column Exclusions
          </v-tab>
          <v-tab-item
            key="policy-column-exclusions"
            lazy
          >
            <v-card flat>
              <table-policy-definition-column-exclusions
                :policyDefinition="policyDefinition"
                :table="table"
                :disabled="disabled"
              ></table-policy-definition-column-exclusions>
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
            lazy
          >
            <v-card flat>
              <policy-realization
                :policyDefinition="policyDefinition"
                :table="table"
                :enableRls="enableRls"
              ></policy-realization>
            </v-card>
          </v-tab-item>

          <v-tab
            v-if="table"
            key="policy-evaluation"
            ripple
          >
            Evaluation
          </v-tab>
          <v-tab-item
            v-if="table"
            key="policy-evaluation"
            lazy
          >
            <v-card flat>
              <table-policy-evaluator-detail
                :policyDefinition="policyDefinition"
                :table="table"
              ></table-policy-evaluator-detail>
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

  import PolicyDefinitionGrantGrid from './TablePolicyDefinitionGrantGrid.vue'
  import PolicyRlsQualifierGrid from './TablePolicyRlsQualifierGrid.vue'
  import TablePolicyDefinitionColumnExclusions from '@/components/TableSecurity/Definition/TablePolicyDefinitionColumnExclusions.vue'
  import PolicyRealization from '@/components/TableSecurity/Realization/TablePolicyRealization.vue'
  import TablePolicyCustomizeDialog from '@/components/TableSecurity/Dialogs/TablePolicyCustomizeDialog.vue'
  import TablePolicyMakeGlobalDialog from '@/components/TableSecurity/Dialogs/TablePolicyMakeGlobalDialog.vue'
  import TablePolicyDeleteDialog from '@/components/TableSecurity/Dialogs/TablePolicyDeleteDialog.vue'
  import TablePolicyEvaluatorDetail from '@/components/TableSecurity/Evaluation/TablePolicyEvaluatorDetail.vue'

  export default {
    name: 'PolicyDefinition',
    components: {
      PolicyDefinitionGrantGrid,
      PolicyRlsQualifierGrid,
      PolicyRealization,
      TablePolicyCustomizeDialog,
      TablePolicyMakeGlobalDialog,
      TablePolicyDeleteDialog,
      TablePolicyEvaluatorDetail,
      TablePolicyDefinitionColumnExclusions
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
        activeTab: ''
      }
    },
    mounted () {
      this.enableRls = this.policyDefinition.enableRls
    },
    watch: {
      policyDefinition () {
        this.enableRls = this.policyDefinition.enableRls
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
      customize () {
        const newPolicyName = `${this.table.name} Custom Policy`
      }
    },
    computed: {
      showDeleteButton () {
        return this.policyDefinition.id !== this.$store.state.defaultPolicy.id
      },
      showMakeGlobalButton () {
        return this.policyDefinition.customIdentifier !== undefined && this.policyDefinition.customIdentifier !== null
      },
      showCustomizeButton () {
        if (this.table) {
          if (this.policyDefinition.customIdentifier) {
            return false
          } else {
            return true
          }
        } else {
          return false
        }
      },
      disabled () {
        const isDefaultPolicy = (this.policyDefinition.id === this.$store.state.defaultPolicy.id)
        const hasTable = this.table !== null && this.table !== undefined
        const isCustomPolicy = this.policyDefinition.customIdentifier ? true : false

        if (isDefaultPolicy) {
          return false
        } else if (hasTable) {
          return !isCustomPolicy
        } else {
          return false
        }
      },
      policyDefinition () {
        const policies = this.$store.state.policies
        const pol = this.$store.state.policies.find(p => p.id === this.policyId)
        return pol
      }
    }
  }
</script>