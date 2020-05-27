<template>
  <v-container
    ma-0 
    pa-0
  >
    <h1>Security Management</h1>
    <hr>
    <v-tabs
      v-model="activeTab"
      dark
    >
      <v-tab
        key="roles"
        ripple
      >
        Role Manager
      </v-tab>
      <v-tab-item
        key="roles"
      >
        <v-card>
          <role-manager-view></role-manager-view>
          <!-- <role-filter></role-filter> -->
        </v-card>
      </v-tab-item>
      
      <v-tab
        key="table-security"
        ripple
        :disabled="initializing"
      >
        Table Security
      </v-tab>
      <v-tab-item
        key="table-security"
      >
        <v-card>
          <table-security-view></table-security-view>
        </v-card>
      </v-tab-item>
      
      <v-tab
        key="function-security"
        ripple
        :disabled="initializing"
      >
        Function Security
      </v-tab>
      <v-tab-item
        key="function-security"
      >
        <v-card>
          <function-security-view></function-security-view>
        </v-card>
      </v-tab-item>
      
      <v-tab
        key="scripts-summary"
        ripple
        :disabled="initializing"
      >
        Scripts Summary
      </v-tab>
      <v-tab-item
        key="scripts-summary"
      >
        <v-card>
          <security-scripts-summary-view></security-scripts-summary-view>
        </v-card>
      </v-tab-item>
      
      <v-tab
        key="help"
        ripple
      >
        Help
      </v-tab>
      <v-tab-item
        key="help"
      >
        <v-container fluid>
          <h2><a href="https://learn.graphile.org/docs/PostgreSQL_Row_Level_Security_Infosheet.pdf" target="_blank">graphile.org rls infosheet</a></h2>
          <v-row no-gutters>
            <v-col align-self="stretch" cols=12>
              <pdf src="https://learn.graphile.org/docs/PostgreSQL_Row_Level_Security_Infosheet.pdf"></pdf>
            </v-col>
          </v-row>
        </v-container>
      </v-tab-item>

    </v-tabs>
  </v-container>
</template>

<script>
  import rp from 'request-promise'

  // import RoleFilter from '@/components/Role/RoleFilter'
  import RoleManagerView from './RoleManagerView'
  import TableSecurityView from './TableSecurityView'
  import FunctionSecurityView from './FunctionSecurityView'
  import SecurityScriptsSummaryView from './SecurityScriptsSummaryView'

  import pdf from 'vue-pdf'

  export default {
    name: 'SecurityView',
    components: {
      FunctionSecurityView,
      TableSecurityView,
      SecurityScriptsSummaryView,
      RoleManagerView,
      pdf
    },
    props: {
    },
    computed: {
      initializing () {
        return this.$store.state.initializing || this.$store.state.dbUserRoles.length === 0
      }
    },
    data: () => ({
      activeTab: 0
    }),
    watch: {
    },
    methods: {
    },
    mounted () {
      this.activeTab = this.$store.state.dbUserRoles.length > 0 ? 0 : 2
    }
  }
</script>

<style>

</style>
