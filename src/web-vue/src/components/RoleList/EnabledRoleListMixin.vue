<template>
  <div>
  </div>
</template>

<script>
  import allEnabledRoles from '@/gql/query/allEnabledRoles.graphql';

  export default {
    name: 'EnabledRoleList',
    data: () => ({
      allEnabledRoles: []
    }),
    apollo: {
      initAllEnabledRoles: {
        query: allEnabledRoles,
        update (result) {
          this.allEnabledRoles = result.allEnabledRoles.nodes
        }
      }
    }
  }
</script>

<style>

</style>
