
<template>
  <v-container
    ma-0 
    pa-0
  >
    <h1>Role Manager</h1>
    <hr>
    <roles></roles>
  </v-container>
</template>
<script>
  // import RoleFilter from '@/components/Role/RoleFilter'
  import Roles from '@/components/Role/Roles'

  export default {
    name: 'RoleManagerView',
    components: {
      Roles,
    },
    props: {
    },
    computed: {
    },
    data: () => ({
    })
  }
</script>

<style>

</style>
