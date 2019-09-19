<template>
  <v-container
    ma-0 
    pa-0
    dense
  >
    <v-treeview
      :items="items"
      activatable
      transition
      :active.sync="active"
      v-model="selected"
      hoverable
      dense
      v-scroll
    ></v-treeview>
</v-container>
</template>

<script>
  import appBus from '../../AppBus'

  export default {
    name: 'SchemaTree',
    data: () => ({
      active: [],
      schemata: [],
      selected: [],
    }),
    computed: {
      items () {
        return this.$store.state.managedSchemata.map(
          schema => {
            return {
              id: `schema:${schema.id}`,
              name: schema.schemaName,
              children: this.filterMode ? [] : [
                {
                  id: `tables:${schema.schemaName}`,
                  name: 'tables',
                  children: schema.schemaTables.filter(t => t.tableType === 'BASE TABLE').sort((a,b)=>{return a.tableName < b.tableName ? -1 : 1})
                    .map(
                      table => {
                        return {
                          id: `table:${table.id}`,
                          name: table.tableName
                        }
                      }
                    )
                },
                {
                  id: `views:${schema.schemaName}`,
                  name: 'views',
                  children: schema.schemaTables.filter(t => t.tableType === 'VIEW').sort((a,b)=>{return a.tableName < b.tableName ? -1 : 1})
                    .map(
                      table => {
                        return {
                          id: `view:${table.id}`,
                          name: table.tableName
                        }
                      }
                    )
                },
                {
                  id: `functions:${schema.schemaName}`,
                  name: 'functions',
                  children: (schema.schemaFunctions || []).sort((a,b)=>{return a.functionName < b.functionName ? -1 : 1})
                    .map(
                      aFunction => {
                        return {
                          id: `function:${aFunction.id}`
                          ,name: aFunction.functionName
                        }
                      }
                    )
                },
                {
                  id: `enums:${schema.schemaName}`,
                  name: 'enums',
                  children: (schema.schemaEnums || []).sort((a,b)=>{return a.enumName < b.enumName ? -1 : 1})
                    .map(
                      aEnum => {
                        return {
                          id: `enum:${aEnum.id}`
                          ,name: aEnum.enumName
                        }
                      }
                    )
                },
                {
                  id: `udts:${schema.schemaName}`,
                  name: 'udts',
                  children: (schema.schemaUdts || []).sort((a,b)=>{return a.udtName < b.udtName ? -1 : 1})
                    .map(
                      aUdt => {
                        return {
                          id: `udt:${aUdt.id}`
                          ,name: aUdt.udtName
                        }
                      }
                    )
                },
              ]
            }
          }
        )
        .sort((a,b)=>{return a.name < b.name ? -1 : 1})
      },
    },
    watch: {
      active () {
        const active = this.active[0] || ''
        const activeType = active.split(':')[0]
        const activeId = active.split(':')[1]

        switch (activeType) {
          case 'table':
            // appBus.$emit('focus-route')
            this.$router.push({ name: 'table', params: { id: activeId }})
          break
          case 'tables':
          break
          case 'view':
            // appBus.$emit('focus-route')
            this.$router.push({ name: 'view', params: { id: activeId }})
          break
          case 'views':
          break
          case 'function':
            // appBus.$emit('focus-route')
            this.$router.push({ name: 'function', params: { id: activeId }})
          break
          case 'enum':
            // appBus.$emit('focus-route')
            this.$router.push({ name: 'enum', params: { id: activeId }})
          break
          case 'udt':
            // appBus.$emit('focus-route')
            this.$router.push({ name: 'udt', params: { id: activeId }})
          break
          default:

          break
        }
      }
    },
  }
</script>

<style>

</style>
