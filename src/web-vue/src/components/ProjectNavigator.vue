<template>
  <v-container>
    <v-toolbar>
      <v-btn @click="toggleFilter">{{filterButtonText}}</v-btn>
      <!-- <v-btn @click="settings">Settings</v-btn> -->
      <!-- <v-btn @click="securityReview">Security Review</v-btn> -->
    </v-toolbar>    
    <v-tabs>
      <v-tab key="schemata">Schemata</v-tab>
      <v-tab-item key="schemata">
        <schema-tree v-if="!filterOn"></schema-tree>
        <schema-filter v-if="filterOn"></schema-filter>
      </v-tab-item>
      <!-- <v-tab key="roles">Roles</v-tab>
      <v-tab-item key="roles">
        <role-list></role-list>
      </v-tab-item> -->
    </v-tabs>
  </v-container>
</template>

<script>
  import SchemaTree from '@/components/Schema/SchemaTree'
  import SchemaFilter from '@/components/Schema/SchemaFilter'
  // import RoleList from '@/components/Role/RoleList'

  export default {
    name: 'ProjectNavigator',
    components: {
      SchemaTree,
      SchemaFilter
      // RoleList
    },
    data: () => ({
      filterOn: false
    }),
    computed: {
      filterButtonText () {
        return this.filterOn ? 'Apply' : 'Filter'
      }
    },
    methods: {
      toggleFilter () {
        this.filterOn = !this.filterOn
      }
      // securityReview () {
      //   this.$router.push({ name: 'security'})
      // },
      // settings () {
      //   this.$router.push({ name: 'settings' })
      // }
    }
  }
</script>

<style>

</style>
