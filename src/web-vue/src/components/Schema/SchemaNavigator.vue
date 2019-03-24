<template>
  <v-container>
    <h1 v-if="loading">REFRESHING SCHEMATA....</h1>
    <v-tabs>
      <v-tab key="schemata">Schemata</v-tab>
      <v-tab-item key="schemata">
        <v-toolbar>
          <v-btn @click="toggleFilter">{{filterButtonText}}</v-btn>
          <v-btn @click="refreshSchemaTree">Refresh</v-btn>
        </v-toolbar>    
        <schema-tree v-if="!filterOn"></schema-tree>
        <schema-filter v-if="filterOn"></schema-filter>
      </v-tab-item>
    </v-tabs>    
  </v-container>
</template>

<script>
  import getDbSchemaTree from '@/gql/query/getDbSchemaTree.graphql';

  import SchemaTree from '@/components/Schema/SchemaTree'
  import SchemaFilter from '@/components/Schema/SchemaFilter'

  export default {
    name: 'SchemaNavigator',
    components: {
      SchemaTree,
      SchemaFilter
    },
    data: () => ({
      filterOn: false,
      forceRefetch: false,
      loading: false
    }),
    computed: {
      filterButtonText () {
        return this.filterOn ? 'Apply' : 'Filter'
      },
      rawSchemata () {
        return this.$store.state.rawSchemata
      },
      // loading () {
      //   return this.$apollo.loading
      // }
    },
    methods: {
      refreshSchemata () {
        this.loading = true
        this.$apollo.query({
          query: getDbSchemaTree,
          fetchPolicy: 'network-only',
        })
        .then(result => {
          this.loading = false
          this.$store.commit('rawSchemata', {rawSchemata: result.data.allSchemata.nodes})
        })
        .catch(error => {
          console.log(error)
          this.loading = false
        })

      },
      toggleFilter () {
        this.filterOn = !this.filterOn
      },
      refreshSchemaTree () {
        this.refreshSchemata()
        // this.$apollo.queries.init.refetch()
      }
    },
    // apollo: {
    //   init: {
    //     query: getDbSchemaTree,
    //     fetchPolicy: 'network-only',
    //     skip () {
    //       console.log('wha', this.forceRefetch, (this.rawSchemata.length > 0), !this.forceRefetch && (this.rawSchemata.length > 0))
    //       const retval = !this.forceRefetch && (this.rawSchemata.length > 0)
    //       this.forceRefetch = true
    //       return retval
    //     },
    //     update (result) {
    //       this.$store.commit('rawSchemata', {rawSchemata: result.allSchemata.nodes})
    //       this.forceRefetch = true
    //     }
      // }
    // }
  }
</script>

<style>

</style>
