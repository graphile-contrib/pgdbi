<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="evaluation.indices"
      class="elevation-1"
      :hide-default-footer="true"
      show-expand
    >
      <template slot="expanded-item" slot-scope="props">
        <td :colspan="headers.length + 1">
          <v-tabs
            dark
            slider-color="yellow"
          >
            <v-tab
              key="create"
              ripple
            >
            Create
            </v-tab>
            <v-tab-item
              key="create"
            >
              <script-viewer
                :scriptText="props.item.indexDefinition"
                :showReadability="false"
              ></script-viewer>
            </v-tab-item>

            <v-tab
              key="drop"
              ripple
            >
            Drop
            </v-tab>
            <v-tab-item
              key="drop"
            >
              <script-viewer
                :scriptText="props.item.indexDrop"
                :showReadability="false"
              ></script-viewer>
            </v-tab-item>
          </v-tabs>
        </td>
      </template>
    </v-data-table>
  </v-container>
</template>

<script>
  import ScriptViewer from '@/components/_common/ScriptViewer'

  export default {
    name: 'TableGenericIndexDetail',
    props: {
      evaluation: {
        type: Object,
        required: true
      }
    },
    components: {
      ScriptViewer
    },
    methods: {
    },
    computed: {
    },
    data: () => ({
      headers: [
        {
          text: 'Index Name',
          value: 'indexName'
        },
        // {
        //   text: 'Evaluation',
        //   value: 'evaluation'
        // }
      ],
    })
  }
</script>

<style>

</style>
