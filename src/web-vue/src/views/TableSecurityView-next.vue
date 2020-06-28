<template>
  <v-container
    ma-0 
    pa-0
  >
    <hr>
    <v-tabs
      v-model="activeTab"
      dark
    >
      <v-tab
        key="profiles"
        ripple
      >
        Table Security Profiles
      </v-tab>
      <v-tab-item
        key="profiles"
      >
        <v-card>
          <v-layout row wrap>
            <v-flex xs12>
              <v-card key="profiles">
                <current-rls-policies></current-rls-policies>
              </v-card>
            </v-flex>
          </v-layout>
        </v-card>
      </v-tab-item>

      <v-tab
        key="classic"
        ripple
      >
        classic
      </v-tab>
      <v-tab-item
        key="classic"
      >
        <v-card>
          <v-layout row wrap>
            <v-flex xs12>
              <v-card key="classic">
                <table-security-profile-manager></table-security-profile-manager>
              </v-card>
            </v-flex>
          </v-layout>
        </v-card>
      </v-tab-item>

      <v-tab
        key="policyAssignment"
        ripple
      >
        Policy Assignment
      </v-tab>
      <v-tab-item
        key="policyAssignment"
      >
        <v-card>
          <v-layout row wrap>
            <v-flex xs12>
              <v-card key="policyAssignment">
                <policy-assignment></policy-assignment>
              </v-card>
            </v-flex>
          </v-layout>
        </v-card>
      </v-tab-item>

      <v-tab
        key="policies"
        ripple
      >
        Schema Security Scripts
      </v-tab>
      <v-tab-item
        key="policies"
      >
        <v-card>
          <schema-security-scripts></schema-security-scripts>
        </v-card>
      </v-tab-item>
      
      <v-tab
        key="policy-manager"
        ripple
      >
        Policy Templates
      </v-tab>
      <v-tab-item
        key="policy-manager"
      >
        <v-card>
          <table-security-profile-manager></table-security-profile-manager>
        </v-card>
      </v-tab-item>

    </v-tabs>
  </v-container>
</template>

<script>
  import PolicyAssignment from '@/components/TableSecurity/Assignment/TablePolicyAssignment'
  // import SecurityPolicySettings from '@/components/Settings/SecurityPolicySettings'
  import SchemaSecurityScripts from '@/components/TableSecurity/Realization/SchemaSecurityScripts'
  import TableSecurityProfileManager from '@/components/TableSecurity/Definition/TableSecurityProfileManager'
  import CurrentRlsPolicies from '@/components/TableSecurity/Rls/CurrentRlsPolicies'
  // import PolicyManager from '@/components/TableSecurity/TablePolicyManager'


  export default {
    name: 'TableSecurityView',
    components: {
      CurrentRlsPolicies,
      // SecurityPolicySettings,
      SchemaSecurityScripts,
      TableSecurityProfileManager,
      PolicyAssignment
    },
    props: {
    },
    computed: {
    },
    data: () => ({
      activeTab: 0
    }),
  }
</script>

<style>

</style>
