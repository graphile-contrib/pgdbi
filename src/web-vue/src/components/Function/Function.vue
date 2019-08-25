<template>
  <v-container>
    <h1>{{ id }}</h1>
    <hr/>
    <script-viewer
      :scriptText="definition"
      @declaration-visibility-changed="declarationVisibilityChanged"
      showDeclarationVisibility
      :showReadability="false"
    ></script-viewer>
  </v-container>
</template>

<script>
  import ScriptViewer from '@/components/_common/ScriptViewer'

  export default {
    name: 'Function',
    components: {
      ScriptViewer
    },
    props: {
      id: {
        type: String,
        required: true
      }
    },
    computed: {
      definition () {
        return this.declarationVisibility === 'hide' ? this.fn.definition.split('$function$')[1] : this.fn.definition
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
      declarationVisibility: 'show'
    }),
    methods: {
      declarationVisibilityChanged (declarationVisibility) {
        this.declarationVisibility = declarationVisibility
      },
      onCopy: function (e) {
        alert('Copied!')
      },
      onError: function (e) {
        alert('Failed to copy texts')
      },
    },
    mounted () {
      const schemaName = this.id.split('.')[0]
      const functionName = this.id.split('.')[1]
      const schema = this.$store.state.managedSchemata.find(s => s.schemaName === schemaName)
      this.fn = schema.schemaFunctions.find(f => f.functionName === functionName)
    }
  }
</script>

<style>

</style>
