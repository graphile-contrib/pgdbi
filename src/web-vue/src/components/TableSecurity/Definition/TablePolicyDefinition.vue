<template>
  <v-container fluid cols=12>
    <v-toolbar dense>
      <v-switch
        v-model="enableRls"
        :label="`Enable RLS`"
        :disabled="disabled"
      ></v-switch>
      <v-spacer></v-spacer>
      <table-policy-make-global-dialog
        v-if="showMakeGlobalButton"
        :policyDefinition="policyDefinition"
      ></table-policy-make-global-dialog>
      <v-spacer></v-spacer>
      <table-policy-delete-dialog
        v-if="showDeleteButton"
        :policyDefinition="policyDefinition"
      ></table-policy-delete-dialog>
      <v-spacer></v-spacer>
      <h4 class="text-no-wrap">{{ title }}</h4>
      <v-spacer></v-spacer>
      <table-policy-rename-dialog
        :policyDefinition="policyDefinition"
      ></table-policy-rename-dialog>
    </v-toolbar>
      <v-tabs
        v-model="activeTab"
        dark
      >
        <v-tab
          key="profile"
          ripple
        >
          Security Profile
        </v-tab>
        <v-tab-item
          key="profile"
        >
          <v-card flat>
            <table-security-profile
              :policyDefinition="policyDefinition"
              :table="table"
              :disabled="disabled"
            ></table-security-profile>
            </v-card>
        </v-tab-item>

        <!-- <v-tab
          key="grants"
          ripple
        >
          Table Grants
        </v-tab>
        <v-tab-item
          key="grants"
        >
          <v-card flat>
          <table-policy-definition-grants
            :policyDefinition="policyDefinition"
            :disabled="disabled"
          ></table-policy-definition-grants>
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
        </v-tab-item> -->

        <v-tab
          key="policy-template"
          ripple
        >
          {{ table ? 'Policy Script' : 'Policy Script Template'}}
        </v-tab>
        <v-tab-item
          key="policy-template"
        >
          <v-card flat>
            <policy-realization
              :policyDefinition="policyDefinition"
              :table="table"
              :enableRls="enableRls"
            ></policy-realization>
          </v-card>
        </v-tab-item>

        <!-- <v-tab
          v-if="table"
          key="policy-evaluation"
          ripple
        >
          Evaluation
        </v-tab>
        <v-tab-item
          v-if="table"
          key="policy-evaluation"
        >
          <v-card flat>
            <table-policy-evaluator-detail
              :policyDefinition="policyDefinition"
              :table="table"
            ></table-policy-evaluator-detail>
          </v-card>
        </v-tab-item> -->
      </v-tabs>

  </v-container>
</template>

<script>
  // import TablePolicyDefinitionGrants from '@/components/TableSecurity/Definition/Grants/TablePolicyDefinitionGrants.vue'

  // import PolicyRlsQualifierGrid from './TablePolicyRlsQualifierGrid.vue'
  import PolicyRealization from '@/components/TableSecurity/Realization/TablePolicyRealization.vue'
  import TablePolicyCustomizeDialog from '@/components/TableSecurity/Dialogs/TablePolicyCustomizeDialog.vue'
  import TablePolicyMakeGlobalDialog from '@/components/TableSecurity/Dialogs/TablePolicyMakeGlobalDialog.vue'
  import TablePolicyDeleteDialog from '@/components/TableSecurity/Dialogs/TablePolicyDeleteDialog.vue'
  import TablePolicyRenameDialog from '@/components/TableSecurity/Dialogs/TablePolicyRenameDialog.vue'
  import TablePolicyEvaluatorDetail from '@/components/TableSecurity/Evaluation/TablePolicyEvaluatorDetail.vue'
  import TableSecurityProfile from './TableSecurityProfile.vue'

  export default {
    name: 'PolicyDefinition',
    components: {
      TableSecurityProfile,
      // PolicyRlsQualifierGrid,
      PolicyRealization,
      TablePolicyCustomizeDialog,
      TablePolicyMakeGlobalDialog,
      TablePolicyDeleteDialog,
      TablePolicyEvaluatorDetail,
      // TablePolicyDefinitionGrants,
      TablePolicyRenameDialog
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
        activeTab: null
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

        if (!this.enableRls && this.activeTab === 1) this.activeTab = 0
      }
    },
    methods: {
      customize () {
        const newPolicyName = `${this.table.name} Custom Policy`
      }
    },
    computed: {
      showDeleteButton () {
        this.policyDefinition.id === this.$store.state.defaultPolicy.id ||
        this.policyDefinition.id === this.$store.state.defaultPolicyPermissive.id
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
        const isDefaultPolicy = (
          this.policyDefinition.id === this.$store.state.defaultPolicy.id ||
          this.policyDefinition.id === this.$store.state.defaultPolicyPermissive.id
        )
        const hasTable = this.table !== null && this.table !== undefined
        const isCustomPolicy = this.policyDefinition.customIdentifier ? true : false

        if (isDefaultPolicy) {
          return true
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
      },
      title () {
        return `Policy Name: ${ this.policyDefinition.name }`
      }
    }
  }
</script>