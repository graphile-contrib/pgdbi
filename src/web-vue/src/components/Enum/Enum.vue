<template>
  <v-container>
    <h1>{{ id }}</h1>
    <hr/>
    <script-viewer
      :scriptText="definition"
      :showDeclarationVisibility="false"
      :showReadability="false"
      skipFormat
    ></script-viewer>
  </v-container>
</template>

<script>
  import ScriptViewer from '@/components/_common/ScriptViewer'

  export default {
    name: 'Enum',
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
        return this.ENUM.enumDefinition
      },
    },
    data: () => ({
      ENUM: {enumDefinition: 'N/A'}
    }),
    methods: {
      onCopy: function (e) {
        alert('Copied!')
      },
      onError: function (e) {
        alert('Failed to copy texts')
      },
      setEnum () {
        const enumSchema = this.id.split('.')[0]
        // const enumName = this.id.split('.')[1]
        const schema = this.$store.state.managedSchemata.find(s => s.schemaName === enumSchema)
        // console.log(enumSchema, enumName, schema)
        this.ENUM = schema.schemaEnums.find(e => e.id === this.id)
        console.log(JSON.stringify(this.enum,null,2))
      }
    },
    mounted () {
      this.setEnum()
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
      
      this.setEnum()
      next()
    },
  }
</script>

<style>

</style>
