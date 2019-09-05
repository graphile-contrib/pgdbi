<template>
  <v-container
    ma-0 
    pa-0
  >
    <v-toolbar>
      <v-btn @click="refreshSchemata" block >Refresh<br>Schemata</v-btn>
    </v-toolbar>    
    <schema-tree
    ></schema-tree>
  </v-container>
</template>

<script>
  import dbIntrospection from '@/gql/query/dbIntrospection.graphql'
  import SchemaTree from '@/components/Schema/SchemaTree'

  export default {
    name: 'SchemaNavigator',
    components: {
      SchemaTree,
    },
    props: {
    },
    data: () => ({
    }),
    computed: {
    },
    watch: {
    },
    methods: {
      refreshSchemata () {
        this.$loading(true)
        this.$apollo.query({
          query: dbIntrospection,
          fetchPolicy: 'network-only'
        })
        .then(result => {
          console.log('schemata', result.data)
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
    }
  }
</script>

<style>

</style>
