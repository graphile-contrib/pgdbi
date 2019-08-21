<template>
  <v-container>
    <h1>{{ id }}</h1>
    <hr/>
    <v-toolbar>
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
      <v-switch
        v-model="hideFunctionDeclaration"
        :label="`Hide Declaration`"
      ></v-switch>
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
  // import functionById from '@/gql/query/functionById.graphql'

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
        return this.hideFunctionDeclaration ? this.fn.definition.split('$function$')[1] : this.fn.definition
      },
      functionName () {
        return this.fn.functionName
      },
      functionSchema () {
        return this.fn.functionSchema
      }
    },
    data: () => ({
      fn: {},
      hideFunctionDeclaration: false
    }),
    methods: {
      onCopy: function (e) {
        alert('Copied!')
      },
      onError: function (e) {
        alert('Failed to copy texts')
      },
    },
    mounted () {
      const schemaName = this.id.split(':')[1].split('.')[0]
      const functionName = this.id.split(':')[1].split('.')[1]
      const schema = this.$store.state.managedSchemata.find(s => s.schemaName === schemaName)
      this.fn = schema.schemaFunctions.find(f => f.functionName === functionName)
    }
  }
</script>

<style>

</style>
