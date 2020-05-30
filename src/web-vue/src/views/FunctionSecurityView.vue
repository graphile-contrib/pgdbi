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
    </v-tabs>
  </v-container>
</template>

<script>
  import PolicyManager from '@/components/FunctionSecurity/FunctionPolicyManager'
  import PolicyAssignment from '@/components/FunctionSecurity/Assignment/FunctionPolicyAssignment'
  import SchemaSecurityScripts from '@/components/FunctionSecurity/Realization/FunctionSchemaSecurityScripts'

  export default {
    name: 'FunctionSecurityView',
    components: {
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
  }
</script>

<style>

</style>
