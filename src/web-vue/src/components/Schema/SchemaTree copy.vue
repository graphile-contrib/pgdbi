<template>
  <v-container
    ma-0 
    pa-0
  >
    <v-toolbar>
      <v-btn @click="filterSchemata">Select Schemata</v-btn>
    </v-toolbar>    
    <v-treeview
      :items="items"
      activatable
      transition
      :active.sync="active"
      v-model="selected"
      hoverable
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
                  children: schema.schemaTables.sort((a,b)=>{return a.name < b.name ? -1 : 1})
                },
                {
                  id: `functions:${schema.name}`,
                  name: 'functions',
                  children: schema.schemaFunctions.sort((a,b)=>{return a.name < b.name ? -1 : 1})
                },
                {
                  id: `enums:${schema.name}`,
                  name: 'enums',
                  children: schema.schemaEnums
                    .sort((a,b)=>{return a.name < b.name ? -1 : 1})
                    .map(
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
        .sort((a,b)=>{return a.name < b.name ? -1 : 1})
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
