<template>
  <v-container
    ma-0 
    pa-0
    fluid
  >
    <h1>PGDBI</h1>
    <h2>postgraphile-db-inspector</h2>
    <v-toolbar>
      <v-btn @click="resetStore">Reset PGDBI</v-btn>
      <v-btn @click="$router.push('project-export')">Export Project</v-btn>
      <v-btn @click="$router.push('project-import')">Import Project</v-btn>
    </v-toolbar>
    <!-- <hr>
    <p>A collection of tools to ensure your postgres database is properly configured to support <a href="https://www.graphile.org/postgraphile/" target="_blank">postgraphile</a></p>
    <hr>
    <h2>use pgdbi to</h2>
    <ul>
      <li>browse tables, functions, enums, udts and more in the schema tree</li>
      <li>manage table and function <router-link :to="{ name: 'security-manager'}">security policies</router-link>
      <li>examine indices associated with <router-link :to="{ name: 'fk-index-manager'}">foreign-keys and unique constraints</router-link></li>
      <li><router-link :to="{ name: 'search-view'}">text-search</router-link> across all functions</li>
      <li>...more to come</li>
    </ul>
    <hr> -->
    <roles></roles>
    <h3>links</h3>
    <ul>
      <li><a href="https://www.graphile.org/postgraphile/">postgraphile</a></li>
      <li><a href="https://www.postgresql.org/docs/">postgres</a></li>
      <li><a href="https://graphql.org/">graphql</a></li>
    </ul>
  </v-container>
</template>

<script>
  import Roles from '@/components/Role/Roles'

  export default {
    name: 'Home',
    components: {
      Roles
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
