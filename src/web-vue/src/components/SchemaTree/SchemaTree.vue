<template>
  <v-container>
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
  import getDbSchemaTree from '@/gql/query/getDbSchemaTree.graphql';

  export default {
    name: 'SchemaTree',
    computed: {
      selectedSchemata () {
        return this.$store.state.schemaFilter
      }
    },
    data: () => ({
      active: [],
      items: [],
      schemata: [],
      selected: []
    }),
    methods: {
      computeItems () {
        const schemataToDisplay = this.selectedSchemata.length === 0 || this.filterMode ? this.schemata : this.schemata.filter(
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
                  }
                ]
              }
            }
          )
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
    apollo: {
      init: {
        query: getDbSchemaTree,
        update (result) {
          this.schemata = result.allSchemata.nodes
          this.computeItems()
        }
      }
    }
  }
</script>

<style>

</style>
