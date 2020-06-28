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
        Security Profile Definition
      </v-tab>
      <v-tab-item
        key="profile"
      >
        <v-card>
          <table-security-profile
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
    name: 'TableSecurityProfileDefinitionView',
    components: {
      TableSecurityProfile
    },
    props: {
      policyDefinitionId: {
        type: String,
        required: true
      }
    },
    computed: {
      policyDefinition () {
        const retval = this.$store.state.policies
          .find(p => p.id.toString() === this.policyDefinitionId.toString())
        return retval
      }
    },
    data: () => ({
      activeTab: 0
    }),
  }
</script>

<style>

</style>
