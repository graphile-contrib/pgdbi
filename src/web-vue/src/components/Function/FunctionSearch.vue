<template>
  <v-container
    ma-0 
    pa-0
  >
    <h2>Search Terms</h2>
    <v-row>
      <v-col cols=3>
        <v-text-field 
          label="search term"
          v-model="searchTerm"
          placeholder="enter a search term"
        ></v-text-field>
      </v-col>
      <v-col cols=1 class="text-center"><h3>OR</h3></v-col>
      <v-col cols=3>
        <v-text-field 
          label="search term"
          v-model="searchTerm1"
          placeholder="enter a search term"
        ></v-text-field>
      </v-col>
      <v-col cols=1 class="text-center"><h3>OR</h3></v-col>
      <v-col cols=3>
        <v-text-field 
          label="search term"
          v-model="searchTerm2"
          placeholder="enter a search term"
        ></v-text-field>
      </v-col>      
    </v-row>
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
    name: 'FunctionSearch',
    components: {
      FunctionList
    },
    props: {
    },
    computed: {
      disabled () {
        return this.searchTerm === undefined || this.searchTerm === null || this.searchTerm === ''
      },
      allFunctions () {
        return this.$store.state.managedSchemata.reduce(
          (all, schema) => {
            return [
              ...all,
              ...schema.schemaFunctions
            ]
          }, []
        )
      },
      functions () {
        return this.allFunctions.filter(
          f => {
            const schema = f.functionSchema.toLowerCase()
            const name = f.functionName.toLowerCase()
            const definition = f.definition.toLowerCase()

            const searchTermResult = (
              schema.indexOf(this.searchTerm.toLowerCase()) !== -1 ||
              name.indexOf(this.searchTerm.toLowerCase()) !== -1 ||
              definition.indexOf(this.searchTerm.toLowerCase()) !== -1
            )
            
            const searchTerm1Result = (
              schema.indexOf(this.searchTerm1.toLowerCase()) !== -1 ||
              name.indexOf(this.searchTerm1.toLowerCase()) !== -1 ||
              definition.indexOf(this.searchTerm1.toLowerCase()) !== -1
            )
              
            const searchTerm2Result = (
              schema.indexOf(this.searchTerm2.toLowerCase()) !== -1 ||
              name.indexOf(this.searchTerm2.toLowerCase()) !== -1 ||
              definition.indexOf(this.searchTerm2.toLowerCase()) !== -1
            )

            return searchTermResult && searchTerm1Result && searchTerm2Result
          }
        )
      }
    },
    watch: {
    },
    data: () => ({
      searchTerm: '',
      searchTerm1: '',
      searchTerm2: ''
    }),
    methods: {
    },
  }
</script>

<style>

</style>
