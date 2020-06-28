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
        key="profile-definitions"
        ripple
      >
        Security Profile Definitions
      </v-tab>
      <v-tab-item
        key="profile-definitions"
      >
        <v-card>
          <table-security-profile-definitions></table-security-profile-definitions>
        </v-card>
      </v-tab-item>

    </v-tabs>
  </v-container>
</template>

<script>
  import PolicyAssignment from '@/components/TableSecurity/Assignment/TablePolicyAssignment'
  // import SecurityPolicySettings from '@/components/Settings/SecurityPolicySettings'
  import SchemaSecurityScripts from '@/components/TableSecurity/Realization/SchemaSecurityScripts'
  import TableSecurityProfileDefinitions from '@/components/TableSecurity/Definition/TableSecurityProfileDefinitions'


  export default {
    name: 'TableSecurityView',
    components: {
      // SecurityPolicySettings,
      SchemaSecurityScripts,
      TableSecurityProfileDefinitions,
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
