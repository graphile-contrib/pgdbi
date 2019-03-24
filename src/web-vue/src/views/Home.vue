<template>
  <v-container
    ma-0 
    pa-0
  >
    <router-link :to="{ path: 'security-manager' }"><h1>security manager</h1></router-link>
    <h2>A tool to ensure that all <a href="https://learn.graphile.org/docs/PostgreSQL_Row_Level_Security_Infosheet.pdf" target="_blank">table grants and rls policies</a> are properly indexed to support postgraphile</h2>
    <router-link :to="{ path: 'fk-index-manager' }"><h1>foreign key indexes</h1></router-link>
    <h2>A tool to ensure that all <a href="https://www.graphile.org/postgraphile/postgresql-indexes/" target="_blank">foreign keys</a> are properly indexed to support postgraphile</h2>
    <router-link :to="{ path: 'smart-comment-manager' }"><h1>smart comment manager</h1></router-link>
    <h2>A tool to ensure that all <a href="https://www.graphile.org/postgraphile/smart-comments/" target="_blank">smart comments</a> are properly configured to support postgraphile</h2  >
  </v-container>
</template>

<script>

  export default {
    name: 'Home',
    components: {
    },
    props: {
    },
    computed: {
    },
    data: () => ({
      activeTab: null
    }),
    apollo: {
    }
  }
</script>

<style>

</style>
