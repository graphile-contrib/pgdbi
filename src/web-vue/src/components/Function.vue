<template>
  <v-container>
    FUNCTION DETAIL - {{ id }}
    <v-textarea
      readonly
      outline
      :value="definition"
      auto-grow
    >
    </v-textarea>
  </v-container>
</template>

<script>
  import functionById from '../gql/query/functionById.graphql'

  export default {
    name: 'Function',
    props: {
      id: {
        type: String,
        required: true
      }
    },
    computed: {
      definition () {
        return this.fn.definition
      }
    },
    data: () => ({
      fn: {}
    }),
    apollo: {
      init: {
        query: functionById,
        variables () {
          return {
            id: this.id
          }
        },
        update (result) {
          this.fn = result.functionById
        }
      }
    }
  }
</script>

<style>

</style>
