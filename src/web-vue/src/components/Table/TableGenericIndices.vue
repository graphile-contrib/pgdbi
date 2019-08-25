<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="items"
      class="elevation-1"
      :hide-default-footer="true"
      show-expand
    >

      <template slot="expanded-item" slot-scope="props">
        <td :colspan="headers.length + 1">
          <script-viewer
            :scriptText="props.item.indexDefinition"
          ></script-viewer>
        </td>
      </template>

    </v-data-table>
  </v-container>
</template>

<script>
  import ScriptViewer from '@/components/_common/ScriptViewer'

  export default {
    name: 'TableGenericIndices',
    props: {
      indices: {
        type: Array,
        required: true
      }
    },
    components: {
      ScriptViewer
    },
    methods: {
      changeSort (column) {
        if (this.pagination.sortBy === column) {
          this.pagination.descending = !this.pagination.descending
        } else {
          this.pagination.sortBy = column
          this.pagination.descending = false
        }
      }
    },
    computed: {
      items () {
        return this.indices
          .map(
            i => {
              const columnNames = i.indexColumns.map(
                ic => {
                  return ic.columnName
                }
              ).join(', ')

              return {
                ...i
                ,columnNames: columnNames
              }
            }
          )
      }
    },
    data: () => ({
      headers: [
        {
          text: 'Column Name',
          value: 'columnNames'
        },
        {
          text: 'Index Name',
          value: 'indexName'
        }
      ],
      pagination: {
        sortBy: 'constraintName',
        rowsPerPage: -1
      },
    })
  }
</script>

<style>

</style>
