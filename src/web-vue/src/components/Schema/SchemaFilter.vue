<template>
  <div>
    <!-- <v-btn @click="apply" :disabled="applyDisabled">Apply</v-btn> -->
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
      // applyDisabled () {
      //   const existingFilters = this.$store.state.roleFilter || []

      //   const allExistingFiltersPresent = existingFilters.reduce(
      //     (result, schemaId) => {
      //       return result ? this.selected.indexOf(schemaId) > -1 : false
      //     }, true
      //   )
      //   return allExistingFiltersPresent && (existingFilters.length === this.selected.length)
      // }
    },
    data: () => ({
      items: [],
      schemata: [],
      selected: [],
      selectedSchemata: []
    }),
    methods: {
      apply () {
        this.$store.commit('schemaFilter', { schemaFilter: this.selected })
      },
      computeItems () {
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
