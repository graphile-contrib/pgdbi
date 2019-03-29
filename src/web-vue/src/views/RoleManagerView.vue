
<template>
  <v-container
    ma-0 
    pa-0
  >
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
