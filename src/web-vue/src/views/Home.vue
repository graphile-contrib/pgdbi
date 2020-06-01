<template>
  <v-container
    ma-0 
    pa-0
    fluid
  >
    <h1>PGDBI</h1>
    <h2>postgraphile-db-inspector</h2>
    <v-toolbar>
      <project-reset-dialog></project-reset-dialog>
    </v-toolbar>
    <roles></roles>
  </v-container>
</template>

<script>
  import Roles from '@/components/Role/Roles'
  import ProjectResetDialog from '@/components/Project/ProjectResetDialog'

  export default {
    name: 'Home',
    components: {
      Roles,
      ProjectResetDialog
    },
    props: {
    },
    computed: {
    },
    data: () => ({
      activeTab: null
    }),
    methods: {
    }
  }
</script>

<style>

</style>
