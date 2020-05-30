
<template>
  <v-container
    ma-0 
    pa-0
  >
    <v-tabs
      v-model="activeTab"
      dark
    >
      <v-tab
        key="script"
        ripple
      >
        Create Roles Script
      </v-tab>
      <v-tab-item
        key="script"
      >
        <v-card>
          <v-layout row wrap>
            <v-flex xs12>
              <v-card key="script">
                <create-roles-realization></create-roles-realization>
              </v-card>
            </v-flex>
          </v-layout>
        </v-card>
      </v-tab-item>
      <v-tab
        key="ownership-policy"
        ripple
      >
        Ownership Policy
      </v-tab>
      <v-tab-item
        key="ownership-policy"
      >
        <v-card>
          <ownership-policy-realization></ownership-policy-realization>
        </v-card>
      </v-tab-item>
      <v-tab
        key="schema-usage"
        ripple
      >
        Schema Usage Script
      </v-tab>
      <v-tab-item
        key="schema-usage"
      >
        <v-card>
          <v-layout row wrap>
            <v-flex xs12>
              <v-card key="schema-usage">
                <schema-usage-realization></schema-usage-realization>
              </v-card>
            </v-flex>
          </v-layout>
        </v-card>
      </v-tab-item>
      <v-tab
        key="table-security"
        ripple
      >
        Table Security
      </v-tab>
      <v-tab-item
        key="table-security"
      >
        <v-card>
          <table-security-scripts></table-security-scripts>
        </v-card>
      </v-tab-item>
      <v-tab
        key="function-security"
        ripple
      >
        Function Security
      </v-tab>
      <v-tab-item
        key="function-security"
      >
        <v-card>
          <function-security-scripts></function-security-scripts>
        </v-card>
      </v-tab-item>
      <v-tab
        key="master-security-policy"
        ripple
        active-class="yellow red--text"
        class="purple black--text"
      >
        Complete Security Policy
      </v-tab>
      <v-tab-item
        key="master-security-policy"
      >
        <v-card>
          <master-security-policy-realization></master-security-policy-realization>
        </v-card>
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>
<script>
  import CreateRolesRealization from '@/components/Role/CreateRolesRealization'
  import SchemaUsageRealization from '@/components/Schema/SchemaUsageRealization'
  import TableSecurityScripts from '@/components/TableSecurity/Realization/SchemaSecurityScripts'
  import FunctionSecurityScripts from '@/components/FunctionSecurity/Realization/FunctionSchemaSecurityScripts'
  import MasterSecurityPolicyRealization from '@/components/Security/MasterSecurityPolicyRealization'
  import OwnershipPolicyRealization from '@/components/Security/OwnershipPolicyRealization'

  export default {
    name: 'SecurityScriptsSummaryView',
    components: {
      CreateRolesRealization,
      SchemaUsageRealization,
      TableSecurityScripts,
      FunctionSecurityScripts,
      MasterSecurityPolicyRealization,
      OwnershipPolicyRealization
    },
    props: {
    },
    computed: {
    },
    data: () => ({
      activeTab: 0
    })
  }
</script>

<style>

</style>
