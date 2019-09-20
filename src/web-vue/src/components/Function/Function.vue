<template>
  <v-container>
    <h1>{{ id }}</h1>
    <hr/>
    <script-viewer
      :scriptText="definition"
      @declaration-visibility-changed="declarationVisibilityChanged"
      :showDeclarationVisibility="false"
      :showReadability="false"
      skipFormat
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
      },
      context: {
        type: String,
        default: 'default'
      }
    },
    computed: {
      definition () {
        const contextMap = {
          default: this.rawFunction,
          trigger: this.triggerFunction
        }
        return contextMap[this.context]
      },
      rawFunction () {
        return this.fn.definition
      },
      modifiedFunction () {
        const fnDeclaration = this.fn.definition.split('$function$')[0]
        const fnBody = this.fn.definition.split('$function$')[1]

        const commentedDeclaration = fnDeclaration.split('\n').map(l => `-- ${l}`).join('\n')

        return `${commentedDeclaration} $function$${fnBody} -- $function$\n`
      },
      triggerFunction () {
        const fnBody = this.fn.definition.split('$function$')[1]
        return fnBody
      },
      functionName () {
        return this.fn.functionName
      },
      functionSchema () {
        return this.fn.functionSchema
      }
    },
    data: () => ({
      fn: {definition: ''},
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
      setFn () {
        const schemaName = this.id.split('.')[0]
        const functionName = this.id.split('.')[1].split('--')[0]
        const schema = this.$store.state.managedSchemata.find(s => s.schemaName === schemaName)
        this.fn = schema.schemaFunctions.find(f => f.id === this.id)
      }
    },
    mounted () {
      this.setFn()
    },
    beforeRouteUpdate (to, from, next) {
      // called when the route that renders this component has changed,
      // but this component is reused in the new route.
      // For example, for a route with dynamic params `/foo/:id`, when we
      // navigate between `/foo/1` and `/foo/2`, the same `Foo` component instance
      // will be reused, and this hook will be called when that happens.
      // has access to `this` component instance.
      // console.log('to', to)
      // console.log('from', from)
      
      this.setFn()
      next()
    },
  }
</script>

<style>

</style>
