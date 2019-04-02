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
    <h2>click here if you want to reset the tool</h2>
    <v-btn @click="resetStore">Reset PGDBI</v-btn>
    <h2>import/export</h2>
    <v-btn @click="$router.push('project-export')">Export Project</v-btn>
    <v-btn @click="$router.push('project-import')">Import Project</v-btn>
    <hr>
    <h1>stuff that mostly works</h1>
    <router-link :to="{ path: 'role-manager' }"><h1>role manager</h1></router-link>
    <h2>Select roles to use with other tools</h2>
    <router-link :to="{ path: 'table-security-manager' }"><h1>table security manager</h1></router-link>
    <h2>A tool to ensure that all <a href="https://learn.graphile.org/docs/PostgreSQL_Row_Level_Security_Infosheet.pdf" target="_blank">table grants and rls policies</a> are properly configured to support postgraphile</h2>
    <router-link :to="{ path: 'function-security-manager' }"><h1>function security manager</h1></router-link>
    <h2>A tool to ensure that all <a href="https://learn.graphile.org/docs/PostgreSQL_Row_Level_Security_Infosheet.pdf" target="_blank">function grants</a> are properly configured to support postgraphile</h2>
    <hr>
    <h1>currently working on this one</h1>
    <router-link :to="{ path: 'fk-index-manager' }"><h1>foreign key index manager</h1></router-link>
    <h2>A tool to ensure that all <a href="https://www.graphile.org/postgraphile/postgresql-indexes/" target="_blank">foreign keys</a> are properly indexed to support postgraphile</h2>
    <hr>
    <h1>stuff that doesn't work yet but will follow similar patterns to the stuff above</h1>
    <router-link :to="{ path: 'smart-comment-manager' }"><h1>smart comment manager</h1></router-link>
    <h2>A tool to ensure that all <a href="https://www.graphile.org/postgraphile/smart-comments/" target="_blank">smart comments</a> are properly configured to support postgraphile</h2  >
    <router-link :to="{ path: 'search' }"><h1>search tool</h1></router-link>
    <h2>A tool to search all tables, enums, functions, etc. that reference a particular string - mostly useful for functions</h2  >
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
    methods: {
      resetStore () {
        this.$store.commit('resetDefaultState')
        this.$router.push('initialize')
      }
    }
  }
</script>

<style>

</style>
