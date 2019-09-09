<template>
  <v-container>
    <v-card
      class="ma-3 pa-3 purple darken-4"
      dense
    >            
      <h2>Create Indices Script</h2>
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
    name: 'CreateIndicesScript',
    components: {
      ScriptViewer
    },
    props: {
      indicesToCreate: {
        type: Array,
        required: true
      }
    },
    methods: {
    },
    computed: {
      scriptText () {
        return this.indicesToCreate.reduce(
          (all, c) => {
            return all.concat(`create index if not exists idx_${c.tableSchema}_${c.tableName}_${c.columnName} on ${c.tableSchema}.${c.tableName} using btree(${c.columnName});\n\n`)
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
