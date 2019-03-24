<template>
  <v-container>
    <h1 v-if="computing">COMPUTING SCHEMA TREE....</h1>
    <v-treeview
      :items="items"
      activatable
      transition
      :active.sync="active"
      v-model="selected"
    ></v-treeview>
</v-container>
</template>

<script>
  // import getDbSchemaTree from '@/gql/query/getDbSchemaTree.graphql';

  export default {
    name: 'SchemaTree',
    computed: {
      selectedSchemata () {
        return this.$store.state.schemaFilter
      },
      rawSchemata () {
        return this.$store.state.rawSchemata
      }
    },
    data: () => ({
      active: [],
      items: [],
      schemata: [],
      selected: [],
      computing: false
    }),
    methods: {
      computeItems () {
        this.computing = true
        const schemataToDisplay = this.selectedSchemata.length === 0 || this.filterMode ? this.rawSchemata : this.rawSchemata.filter(
            s => {
              return this.selectedSchemata.indexOf(s.id) > -1
            }
          )

          this.items = schemataToDisplay.map(
            schema => {
              return {
                id: `schema:${schema.schemaName}`,
                name: schema.schemaName,
                children: this.filterMode ? [] : [
                  {
                    id: `tables:${schema.schemaName}`,
                    name: 'tables',
                    children: schema.schemaTables
                  },
                  {
                    id: `functions:${schema.name}`,
                    name: 'functions',
                    children: schema.schemaFunctions
                  },
                  {
                    id: `enums:${schema.name}`,
                    name: 'enums',
                    children: schema.schemaEnums.map(
                      e => {
                        return {
                          id: e.id
                          ,name: e.name
                          ,children: e.enumValues.map(
                            ev => {
                              return {
                                id: `ev:${e.name}:${ev}`,
                                name: ev
                              }
                            }
                          )
                        }
                      }
                    )
                  }
                ]
              }
            }
          )
        this.computing = false
      },
    },
    watch: {
      selectedSchemata () {
        this.computeItems()
      },
      active () {
        const active = this.active[0] || ''
        const activeType = active.split(':')[0]
        
        switch (activeType) {
          case 'table':
            this.$router.push({ name: 'table', params: { id: active }})
          break
          case 'tables':
          break
          case 'function':
            this.$router.push({ name: 'function', params: { id: active }})
          break
          default:

          break
        }
      }
    },
    mounted () {
      this.computeItems()
    }
    // apollo: {
    //   init: {
    //     query: getDbSchemaTree,
    //     skip () {
    //       if (this.rawSchemata.length > 0) {
    //         this.computeItems()
    //         return true
    //       } else {
    //         return false
    //       }
    //     },
    //     update (result) {
    //       this.$store.commit('rawSchemata', {rawSchemata: result.allSchemata.nodes})
    //       this.computeItems()
    //     }
    //   }
    // }
  }
</script>

<style>

</style>
