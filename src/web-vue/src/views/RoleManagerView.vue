
<template>
  <v-container
    ma-0 
    pa-0
  >
    <h1>Role Manager</h1>
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
                <roles></roles>
              </v-card>
            </v-flex>
          </v-layout>
        </v-card>
      </v-tab-item>
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
    </v-tabs>
  </v-container>
</template>
<script>
  import Roles from '@/components/Role/Roles'
  import CreateRolesRealization from '@/components/Role/CreateRolesRealization'

  export default {
    name: 'RoleManagerView',
    components: {
      Roles,
      CreateRolesRealization
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
