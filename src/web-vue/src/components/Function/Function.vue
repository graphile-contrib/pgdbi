<template>
  <v-container>
    <h1>{{ id }}</h1>
    <hr/>
    <v-toolbar>
      <v-layout
        align-center
        align-content-center
        justify-center
        justify-content-center
      >
        <!-- <v-tooltip bottom>
          <template v-slot:activator="{ on }">
            <v-btn @click="expand" v-on="on"><v-icon>note_add</v-icon>Expand</v-btn>
          </template>
          <span>Expand</span>
        </v-tooltip> -->
        <v-tooltip bottom>
          <template v-slot:activator="{ on }">
            <v-btn 
              v-on="on" 
              v-clipboard:copy="definition"
              v-clipboard:success="onCopy"
              v-clipboard:error="onError"
            ><v-icon>file_copy</v-icon>Copy
          </v-btn>
          </template>
          <span>Copy</span>
        </v-tooltip>
        <v-spacer></v-spacer>
      </v-layout>
    </v-toolbar>
    <v-textarea
      readonly
      :value="definition"
      auto-grow
      background-color="black"
      disabled
    >
    </v-textarea>
  </v-container>
</template>

<script>
  import functionById from '@/gql/query/functionById.graphql'

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
      },
      functionName () {
        return this.fn.functionName
      },
      functionSchema () {
        return this.fn.functionSchema
      }
    },
    data: () => ({
      fn: {}
    }),
    methods: {
      onCopy: function (e) {
        alert('Copied!')
      },
      onError: function (e) {
        alert('Failed to copy texts')
      },
    },
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
