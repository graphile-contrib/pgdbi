<template>
  <v-container
    ma-0 
    pa-0
  >
    <v-toolbar>
      <v-btn @click="applyFilter" :disabled="applyDisabled" >Use Selected Schemata</v-btn>
    </v-toolbar>    
    <h1 v-if="computing">Refreshing Schemata....</h1>
    <v-treeview
      :items="items"
      transition
      :selectable="true"
      v-model="selected"
    ></v-treeview>
  </v-container>
</template>

<script>
  import dbIntrospection from '@/gql/query/dbIntrospection.graphql'
  // import getDbSchemaList from '@/gql/query/getDbSchemaList.graphql';
  // import getDbSchemaTreeBySchemaName from '@/gql/query/getDbSchemaTreeBySchemaName.graphql'

  export default {
    name: 'SchemaFilter',
    computed: {
      applyDisabled () {
        return this.selected.length === 0
      }
    },
    data: () => ({
      items: [],
      schemata: [],
      selected: [],
      selectedSchemata: [],
      computing: false
    }),
    props: {
    },
    methods: {
      applyFilter () {
        this.computing = true
        this.$apollo.query({
          query: getDbSchemaTreeBySchemaName,
          variables: {
            schemaNames: this.selected
          }
        })
        .then(result => {
          this.$store.commit('setManagedSchemata', result.data.allSchemata.nodes)
          this.computing = false
        })
        .catch(error => {
          console.error(error)
          this.computing = false
        })
      },
      computeItems () {
        this.computing = true
        const selectedSchemata = this.$store.state.managedSchemata || []
        const schemataToDisplay = this.schemata

        this.items = schemataToDisplay.map(
          schema => {
            return {
                // id: `schema:${schema.schemaName}`,
                id: schema.schemaName,
                name: schema.schemaName,
              children: []
            }
          }
        )

        this.selected = selectedSchemata.reduce(
          (all, s) => {
            return all.concat([s.schemaName])
          }, []
        )
        this.computing = false
      },
    },
    watch: {
    },
    apollo: {
      init: {
        query: dbIntrospection,
        update (result) {
          this.schemata = result.dbIntrospection
          this.computeItems()          
        }
      }
    }
  }
</script>

<style>

</style>
