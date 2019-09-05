<template>
  <v-container>
    <v-card
      class="ma-3 pa-3 purple darken-4"
      dense
    >            
      <h2>Drop Indices Script</h2>
        <script-viewer
          :scriptText="scriptText"
          :showReadability="false"
        ></script-viewer>
    </v-card>
  </v-container>
</template>

<script>
  import ScriptViewer from '@/components/_common/ScriptViewer'
  
  export default {
    name: 'DropIndicesScript',
    components: {
      ScriptViewer
    },
    props: {
      indicesToDrop: {
        type: Array,
        required: true
      }
    },
    methods: {
    },
    computed: {
      scriptText () {
        return this.indicesToDrop.reduce(
          (all, i) => {
            return all.concat(`drop index ${i.tableSchema}.${i.indexName};\n\n`)
          }, ''
        )
      }
    },
    data: () => ({
    })
  }
</script>

<style>

</style>
