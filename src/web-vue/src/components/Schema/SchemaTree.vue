<template>
  <v-container>
    <v-toolbar>
      <v-btn @click="filterSchemata">Filter</v-btn>
    </v-toolbar>    
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
  export default {
    name: 'SchemaTree',
    computed: {
      managedSchemata () {
        return this.$store.state.managedSchemata
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
      filterSchemata () {
        this.$store.commit('filterSchemata')
      },
      computeItems () {
        this.computing = true
        this.items = this.managedSchemata.map(
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
      managedSchemata () {
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
  }
</script>

<style>

</style>
