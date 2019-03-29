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
        key="roles"
        ripple
      >
        Roles
      </v-tab>
      <v-tab-item
        key="roles"
      >
        <v-card>
          <v-layout row wrap>
            <v-flex xs12>
              <v-card key="roles">
                <role-filter></role-filter>
              </v-card>
            </v-flex>
          </v-layout>
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
          <policy-manager></policy-manager>
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
              <v-card key="olicyAssignment">
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

    </v-tabs>
  </v-container>
</template>

<script>
  import RoleFilter from '@/components/Role/RoleFilter'
  import PolicyAssignment from '@/components/TableSecurity/TablePolicyAssignment'
  import SecurityPolicySettings from '@/components/Settings/SecurityPolicySettings'
  import SchemaSecurityScripts from '@/components/TableSecurity/SchemaSecurityScripts'
  import PolicyManager from '@/components/TableSecurity/TablePolicyManager'

  export default {
    name: 'TableSecurityView',
    components: {
      RoleFilter,
      SecurityPolicySettings,
      SchemaSecurityScripts,
      PolicyManager,
      PolicyAssignment
    },
    props: {
    },
    computed: {
    },
    data: () => ({
      activeTab: null
    }),
    apollo: {
    }
  }
</script>

<style>

</style>
