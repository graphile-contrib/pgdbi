<template>
  <v-container fluid>
    <v-card
      class="ma-3 pa-3 green darken-3"
      dense
    >            
      <h2>Indexed</h2>
      <hr>
      <v-data-table
        :items="goodIndices"
        :headers="headers"
        class="elevation-1 text-no-wrap"
        hide-default-footer
        show-expand
        calculate-widths
        dense
      >
        <template v-slot:item.evaluation="{ item }">
          <span :class="item.indexDisplayClass">{{ item.evaluation }}</span>
        </template>

        <template slot="expanded-item" slot-scope="props">
          <td :colspan="headers.length + 1">
            <table-generic-index-detail
              :evaluation="props.item"
            ></table-generic-index-detail>
          </td>
        </template>
      </v-data-table>
    </v-card>

    <v-card
      class="ma-3 pa-3 red darken-3"
      dense
    >            
      <h2>Over-Indexed</h2>
      <hr>
      <v-data-table
        :items="badIndices"
        :headers="headers"
        class="elevation-1 text-no-wrap"
        hide-default-footer
        show-expand
        calculate-widths
        dense
      >
        <template v-slot:item.columnDisplay="{ item }">
          <div v-for="col in item.columnDisplay" :key="col">{{col}}</div>
        </template>

        <template v-slot:item.evaluation="{ item }">
          <span :class="item.indexDisplayClass">{{ item.evaluation }}</span>
        </template>

        <template slot="expanded-item" slot-scope="props">
          <td :colspan="headers.length + 1">
            <table-generic-index-detail
              :evaluation="props.item"
            ></table-generic-index-detail>
          </td>
        </template>
      </v-data-table>
    </v-card>
  </v-container>
</template>

<script>
  import ScriptViewer from '@/components/_common/ScriptViewer'
  import TableGenericIndexDetail from '@/components/Table/TableGenericIndexDetail'
  const MULTIPLE_INDICES = 'MULTIPLE_INDICES'

  export default {
    name: 'TableGenericIndices',
    props: {
      tableInfo: {
        type: Object,
        required: true
      }
    },
    components: {
      TableGenericIndexDetail
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
        const evaluations = this.$store.state.genericIndexEvaluations
        return Object.keys(evaluations)
          .filter(key => evaluations[key].tableKey === `${this.tableInfo.tableSchema}.${this.tableInfo.tableName}` )
          .map(key => evaluations[key])          
      },
      goodIndices () {
        return this.items.filter(i => i.evaluation !== MULTIPLE_INDICES)
      },
      badIndices () {
        return this.items.filter(i => i.evaluation === MULTIPLE_INDICES)
          .map(
            idx => {
              return {
                ...idx,
                columnDisplay: idx.idxColumns.split('+')
              }
            }
          )
      },
      duplicateIndexSets () {
        return this.tableInfo.indices
          .reduce(
            (all, index) => {
              const existing = all
            }, []
          )
          // .map(
          //   i => {
          //     const columnNames = i.indexColumns.map(
          //       ic => {
          //         return ic.columnName
          //       }
          //     ).join(', ')

          //     return {
          //       ...i
          //       ,columnNames: columnNames
          //     }
          //   }
          // )
      }
    },
    data: () => ({
      selected: [],
      headers: [
        {
          text: 'Index Columns',
          value: 'columnDisplay'
        },
        {
          text: 'Evaluation',
          value: 'evaluation'
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
