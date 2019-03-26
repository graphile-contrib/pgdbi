<template>
  <div>
    <v-btn @click="apply">Apply</v-btn>
    <h1 v-if="computing">Refreshing Schemata....</h1>
    <v-treeview
      :items="items"
      transition
      :selectable="true"
      v-model="selected"
    ></v-treeview>
  </div>
</template>

<script>
  import getDbSchemaList from '@/gql/query/getDbSchemaList.graphql';
  import getDbSchemaTreeBySchemaName from '@/gql/query/getDbSchemaTreeBySchemaName.graphql'

  export default {
    name: 'SchemaFilter',
    computed: {
    },
    data: () => ({
      items: [],
      schemata: [],
      selected: [],
      selectedSchemata: [],
      computing: false
    }),
    props: {
      afterApply: {
        type: Function,
        required: true
      }
    },
    methods: {
      apply () {
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
          this.afterApply()
        })
        .catch(error => {
          console.error(error)
          this.computing = false
          this.afterApply()
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
console.log('wha', selectedSchemata)
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
        query: getDbSchemaList,
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
