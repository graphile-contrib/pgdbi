<template>
  <v-container>
    <v-toolbar>
      <v-btn @click="settings">Settings</v-btn>
      <v-btn @click="securityReview">Security Review</v-btn>
    </v-toolbar>
    <v-tabs>
      <v-tab key="schemata">Schemata</v-tab>
      <v-tab-item key="schemata">
        <schema-tree></schema-tree>
      </v-tab-item>
      <v-tab key="roles">Roles</v-tab>
      <v-tab-item key="roles">
        <role-list></role-list>
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>

<script>
  import SchemaTree from '@/components/SchemaTree/SchemaTree'
  import RoleList from '@/components/RoleList/RoleList'

  export default {
    name: 'ProjectNavigator',
    components: {
      SchemaTree,
      RoleList
    },
    data: () => ({
    }),
    methods: {
      securityReview () {
        this.$router.push({ name: 'security'})
      },
      settings () {
        this.$router.push({ name: 'settings' })
      }
    }
  }
</script>

<style>

</style>
