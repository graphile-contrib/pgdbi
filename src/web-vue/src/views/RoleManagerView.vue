
<template>
  <v-container
    ma-0 
    pa-0
  >
    <h1>Role Manager</h1>
    <h2>Select roles to use with other tools</h2>
    <hr>
    <role-filter></role-filter>
  </v-container>
</template>
<script>
  import RoleFilter from '@/components/Role/RoleFilter'

  export default {
    name: 'RoleManagerView',
    components: {
      RoleFilter,
    },
    props: {
    },
    computed: {
    },
    data: () => ({
    }),
    apollo: {
    }
  }
</script>

<style>

</style>
