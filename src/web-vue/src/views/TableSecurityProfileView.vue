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
        key="profile"
        ripple
      >
        Security Profile
      </v-tab>
      <v-tab-item
        key="profile"
      >
        <v-card>
          {{ table.id }}
          <table-security-profile
            :table="table"
            :policyDefinition="policyDefinition"
          ></table-security-profile>
        </v-card>
      </v-tab-item>

    </v-tabs>
  </v-container>
</template>

<script>
  import TableSecurityProfile from '@/components/TableSecurity/Definition/TableSecurityProfile'


  export default {
    name: 'TableSecurityProfileView',
    components: {
      TableSecurityProfile
    },
    props: {
      tableId: {
        type: String,
        required: true
      }
    },
    computed: {
      table () {
        const [schemaName, tableName] = this.tableId.split('.')
        return this.$store.state.managedSchemata.find(s => s.schemaName === schemaName).schemaTables.find(t => t.tableName === tableName)
      },
      policyDefinition () {
        const policyDefinitionId = this.$store.state.tablePolicyAssignments[this.tableId].policyDefinitionId
        return this.$store.state.policies.find(p => p.id === policyDefinitionId)       
      }
    },
    data: () => ({
      activeTab: 0
    }),
  }
</script>

<style>

</style>
