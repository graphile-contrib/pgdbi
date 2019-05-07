<template>
  <v-container
    ma-0 
    pa-0
  >
    <v-text-field 
      label="Search Term"
      v-model="searchTerm"
    ></v-text-field>
    <v-btn 
      @click="performSearch"
      :disabled="disabled"
    >Search</v-btn>
    <hr>
    <function-list
      :functions="functions"
    ></function-list>
  </v-container>
</template>

<script>
  import searchFunctions from '@/gql/mutation/searchFunctions.graphql'
  import FunctionList from '@/components/Function/FunctionList'

  export default {
    name: 'SearchView',
    components: {
      FunctionList
    },
    props: {
    },
    computed: {
      disabled () {
        return this.searchTerm === undefined || this.searchTerm === null || this.searchTerm === ''
      }
    },
    data: () => ({
      searchTerm: 'into SCHEMA.TABLE',
      functions: []
    }),
    methods: {
      performSearch () {
        this.$apollo.mutate({
          mutation: searchFunctions,
          variables: {
            searchTerm: this.searchTerm
          }
        })
        .then(result => {
          this.functions = result.data.searchFunctions
        })
        .catch(error => {
          console.log(error)
        })
      }
    },
  }
</script>

<style>

</style>
