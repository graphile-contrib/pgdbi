<template>
  <div>
    <!-- <v-btn @click="apply" :disabled="applyDisabled">Apply</v-btn> -->
    <h1 v-if="computing">COMPUTING SCHEMA TREE....</h1>
    <v-treeview
      :items="items"
      transition
      :selectable="true"
      v-model="selected"
    ></v-treeview>
  </div>
</template>

<script>
  import getDbSchemaTree from '@/gql/query/getDbSchemaTree.graphql';

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
    methods: {
      apply () {
        this.$store.commit('schemaFilter', { schemaFilter: this.selected })
      },
      computeItems () {
        this.computing = true
        const selectedSchemata = this.$store.state.schemaFilter || []
        const schemataToDisplay = this.schemata

        this.items = schemataToDisplay.map(
          schema => {
            return {
                id: `schema:${schema.schemaName}`,
                name: schema.schemaName,
              children: []
            }
          }
        )

        this.selected = selectedSchemata
        this.computing = false
      },
    },
    watch: {
      selected () {
        this.apply()
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
