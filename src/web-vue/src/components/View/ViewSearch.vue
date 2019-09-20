<template>
  <v-container
    ma-0 
    pa-0
  >
    <h2>Enter a search term to find functions of interest</h2>
    <v-text-field 
      label="Search Term"
      v-model="searchTerm"
    ></v-text-field>
    <hr>
    <function-list
      :functions="functions"
    ></function-list>
  </v-container>
</template>

<script>
  import searchViews from '@/gql/mutation/searchViews.graphql'
  import ViewList from '@/components/View/ViewList'

  export default {
    name: 'ViewSearch',
    components: {
      ViewList
    },
    props: {
    },
    computed: {
      disabled () {
        return this.searchTerm === undefined || this.searchTerm === null || this.searchTerm === ''
      },
      allViews () {
        return this.$store.state.managedSchemata.reduce(
          (all, schema) => {
            return [
              ...all,
              ...schema.schemaViews
            ]
          }, []
        )
      },
      functions () {
        return this.allViews.filter(
          f => {
            return f.functionSchema.toLowerCase().indexOf(this.searchTerm.toLowerCase()) !== -1 ||
            f.functionName.toLowerCase().indexOf(this.searchTerm.toLowerCase()) !== -1 ||
            f.definition.toLowerCase().indexOf(this.searchTerm.toLowerCase()) !== -1
          }
        )
      }
    },
    watch: {
    },
    data: () => ({
      searchTerm: '',
    }),
    methods: {
    },
  }
</script>

<style>

</style>
