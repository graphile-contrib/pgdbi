<template>
  <v-container
    ma-5
    pa-5
  >
    <v-tabs
      v-model="activeTab"
      dark
    >      
      <v-tab
        key="initialize"
        ripple
      >
        Initialize Project
      </v-tab>
      <v-tab-item
        key="initialize"
      >
        <v-card>
          <roles></roles>
          <v-card-actions>
            <v-btn :class="refreshBtnClass" :color="refreshBtnColor" @click="refreshSchemata" >Refresh Schemata</v-btn>
          </v-card-actions>
        </v-card>
      </v-tab-item>
      <v-tab
        key="import"
        ripple
      >
        Import Project
      </v-tab>
      <v-tab-item
        key="import"
      >
        <v-card>
          <project-import></project-import>
        </v-card>
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>

<script>
  import dbIntrospection from '@/gql/query/dbIntrospection.graphql'
  import ProjectImport from '@/components/Project/ProjectImport'
  import Roles from '@/components/Role/Roles'

  export default {
    name: 'Initialize',
    components: {
      ProjectImport,
      Roles
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
          this.$store.dispatch('setManagedSchemata', {
            schemaTree: result.data.dbIntrospection.schemaTree,
            pgdbiOptions: {pgdbiOptions: result.data.pgdbiOptions}
          })
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
