
<template>
  <v-container
    ma-0 
    pa-0
  >
    <h1>Security Scripts Summary</h1>
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
    </v-tabs>
  </v-container>
</template>
<script>
  import CreateRolesRealization from '@/components/Role/CreateRolesRealization'
  import SchemaUsageRealization from '@/components/Schema/SchemaUsageRealization'
  import TableSecurityScripts from '@/components/TableSecurity/Realization/SchemaSecurityScripts'
  import FunctionSecurityScripts from '@/components/FunctionSecurity/Realization/FunctionSchemaSecurityScripts'

  export default {
    name: 'SecurityScriptsSummaryView',
    components: {
      CreateRolesRealization,
      SchemaUsageRealization,
      TableSecurityScripts,
      FunctionSecurityScripts
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
