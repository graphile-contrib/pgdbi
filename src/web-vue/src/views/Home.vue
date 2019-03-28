<template>
  <v-container
    ma-0 
    pa-0
  >
    <h1>PGDBI</h1>
    <h2>postgraphile-db-inspector</h2>
    <hr>
    <h2>A collection of tools to ensure your postgres database is properly configured to support <a href="https://www.graphile.org/postgraphile/" target="_blank">postgraphile</a></h2>
    <hr>
    <router-link :to="{ path: 'security-manager' }"><h1>table security manager</h1></router-link>
    <h2>A tool to ensure that all <a href="https://learn.graphile.org/docs/PostgreSQL_Row_Level_Security_Infosheet.pdf" target="_blank">table grants and rls policies</a> are properly configured to support postgraphile</h2>
    <router-link :to="{ path: 'function-security-manager' }"><h1>function security manager</h1></router-link>
    <h2>A tool to ensure that all <a href="https://learn.graphile.org/docs/PostgreSQL_Row_Level_Security_Infosheet.pdf" target="_blank">function grants</a> are properly configured to support postgraphile</h2>
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
