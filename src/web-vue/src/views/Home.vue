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
        Policy Manager
      </v-tab>
      <v-tab-item
        key="policy-manager"
      >
        <v-card>
          <policy-manager></policy-manager>
        </v-card>
      </v-tab-item>

      <v-tab
        key="settings"
        ripple
      >
        Security Policy Settings
      </v-tab>
      <v-tab-item
        key="securityPolicySettings"
      >
        <v-card>
          <v-layout row wrap>
            <v-flex xs12>
              <v-card key="securityPolicySettings">
                <security-policy-settings></security-policy-settings>
              </v-card>
            </v-flex>
          </v-layout>
        </v-card>
      </v-tab-item>

      <v-tab
        key="policies"
        ripple
      >
        Security Policies
      </v-tab>
      <v-tab-item
        key="policies"
      >
        <v-card>
          <security-policy></security-policy>
        </v-card>
      </v-tab-item>

      <v-tab
        key="securityReview"
        ripple
      >
        Security Review
      </v-tab>
      <v-tab-item
        key="securityReview"
      >
        <v-card>
          <security-review></security-review>
        </v-card>
      </v-tab-item>

    </v-tabs>
  </v-container>
</template>

<script>
  import RoleFilter from '@/components/Role/RoleFilter'
  import SecurityPolicySettings from '@/components/Settings/SecurityPolicySettings'
  import SecurityPolicy from '@/components/Security/SecurityPolicy'
  import SecurityReview from '@/components/Security/SecurityReview'
  import PolicyManager from '@/components/Policy/PolicyManager'

  export default {
    name: 'Home',
    components: {
      RoleFilter,
      SecurityPolicySettings,
      SecurityPolicy,
      SecurityReview,
      PolicyManager
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
