<template>
  <v-container
    ma-0 
    pa-0
    fluid
  >
    <!-- <v-toolbar>
      <v-btn :class="refreshBtnClass" :color="refreshBtnColor" @click="refreshSchemata" block>Refresh<br>Schemata</v-btn>
    </v-toolbar>     -->
    <h2 text-right>schemata</h2>
    <schema-tree
    ></schema-tree>
  </v-container>
</template>

<script>
  // import dbIntrospection from '@/gql/query/dbIntrospection.graphql'
  import SchemaTree from '@/components/Schema/SchemaTree'

  export default {
    name: 'SchemaNavigator',
    components: {
      SchemaTree,
    },
    props: {
    },
    data: () => ({
      // refreshBtnClass: 'refreshBtn',
      // refreshBtnColor: 'blue-grey'
    }),
    computed: {
      // initializing () {
      //   return this.$store.state.initializing
      // },
    },
    watch: {
      // initializing () {
      //   this.setRefreshBtnClass()
      // }
    },
    methods: {
      // setRefreshBtnClass () {
      //   this.refreshBtnClass = this.initializing ? 'refreshBtnInitializing' : 'refreshBtn' 
      //   this.refreshBtnColor = this.initializing ? 'yellow darken-3' : 'blue-grey' 
      // },
      // refreshSchemata () {
      //   this.$loading(true)
      //   this.$apollo.query({
      //     query: dbIntrospection,
      //     fetchPolicy: 'network-only'
      //   })
      //   .then(result => {
      //     this.$store.commit('setManagedSchemata', result.data.dbIntrospection.schemaTree)
      //     this.$store.commit('setEnabledRoles', {enabledRoles: result.data.dbIntrospection.enabledRoles})
      //     this.$store.commit('setPgdbiOptions', {pgdbiOptions: result.data.pgdbiOptions})
      //     this.$loading(false)
      //   })
      //   .catch(error => {
      //     this.$loading(false)
      //     console.error(error)
      //     alert(error.toString())
      //   })
      // },
    },
    // mounted() {
    //   this.setRefreshBtnClass()
    // }
  }
</script>

<style>
@keyframes shadow-pulse
{
  0% {
    box-shadow: 0 0 0 0px rgba(182, 179, 26, 0.253);
  }
  100% {
    box-shadow: 0 0 0 15px rgba(182, 179, 26, 0.253);
  }
}

.refreshBtnInitializing
{
  animation: shadow-pulse 2s infinite;
}
</style>
