<template>
  <v-container
    ma-5
    pa-5
  >
    <v-btn :class="refreshBtnClass" :color="refreshBtnColor" @click="refreshSchemata" >Refresh Schemata</v-btn>
    <h2>or...</h2>
    <project-import></project-import>
  </v-container>
</template>

<script>
  import dbIntrospection from '@/gql/query/dbIntrospection.graphql'
  import ProjectImport from '@/components/Project/ProjectImport'

  export default {
    name: 'Initialize',
    components: {
      ProjectImport
    },
    props: {
    },
    computed: {
      initializing () {
        return this.$store.state.initializing
      }
    },
    data: () => ({
      activeTab: null,
      refreshBtnClass: 'refreshBtnInitializing',
      refreshBtnColor: 'yellow darken-3'
    }),
    methods: {
      refreshSchemata () {
        this.$loading(true)
        this.$apollo.query({
          query: dbIntrospection,
          fetchPolicy: 'network-only'
        })
        .then(result => {
          this.$store.commit('setManagedSchemata', result.data.dbIntrospection.schemaTree)
          this.$store.commit('setEnabledRoles', {enabledRoles: result.data.dbIntrospection.enabledRoles})
          this.$store.commit('setPgdbiOptions', {pgdbiOptions: result.data.pgdbiOptions})
          this.$loading(false)
        })
        .catch(error => {
          this.$loading(false)
          console.error(error)
          alert(error.toString())
        })
      },
    },
    watch: {
      initializing () {
        if (this.initializing !== true) {
          this.$router.push({name:'security-manager'})
        }
      }
    },
    beforeRouteLeave (to, from, next) {
      if (this.initializing) {
        next(false)
      } else {
        next()
      }
    }
  }
</script>

<style>

</style>
