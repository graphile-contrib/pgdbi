<template>
  <v-container>
    <h2>Existing Indices</h2>
    <v-data-table
      v-model="selected"
      :headers="headers"
      :items="evaluation.indices"
      class="elevation-1"
      :hide-default-footer="true"
      show-expand
      show-select
      @item-selected="itemSelected"
    >
      <template slot="header.data-table-select">
        Drop
      </template>
      
      <template slot="expanded-item" slot-scope="props">
        <td :colspan="headers.length + 2">
          <h2>Current Realization in Database Under Development</h2>
          <script-viewer
            :scriptText="props.item.indexDefinition"
            :showReadability="false"
            :showToolbar="false"
          ></script-viewer>
        </td>
      </template>
    </v-data-table>
    <h2>Current Realization To Be Generated</h2>
    <script-viewer
      :scriptText="desiredRealization"
      :showReadability="false"
    ></script-viewer>
  </v-container>
</template>

<script>
  import ScriptViewer from '@/components/_common/ScriptViewer'

  export default {
    name: 'GenericIndexDetail',
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
      itemSelected (item) {
        this.$store.commit('toggleIndexForDrop', item)
      }
    },
    computed: {
      existingIndices () {
        return this.evaluation.indices || []
      },
      desiredRealization () {
        const dropText = this.evaluation.desiredRealization.drop ? `-- INDICES TO DROP\n\n ${this.evaluation.desiredRealization.drop}` : ''
        const createText = this.evaluation.desiredRealization.create ? `-- INDICES TO CREATE\n\n ${this.evaluation.desiredRealization.create}` : ''
        const dr = dropText.concat('\n\n').concat(createText)
        return dr
      }
    },
    data: () => ({
      selected: [],
      headers: [
        {
          text: '',
          value: 'drop',
          width: '5%'
        },
        {
          text: 'Index Name',
          value: 'indexName'
        },
      ],
    }),
    mounted () {
      const theseIndicesNames = this.evaluation.indices.map(i => i.indexName)

      this.selected = this.evaluation.indices.filter(i => this.$store.state.indicesToDrop[i.indexName] !== undefined)
    }
  }
</script>

<style>

</style>
