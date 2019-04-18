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
