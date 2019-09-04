<template>
  <v-container fluid>
    <v-data-table
      :headers="headers"
      :items="tableDetail"
      class="elevation-1 text-no-wrap"
      hide-default-footer
      calculate-widths
      dense
      :items-per-page="100"
    >
    <template v-slot:item.isPKColumn="{ item }">
      <v-icon v-if="item.isPKColumn">check</v-icon>
    </template>

    <template v-slot:item.isNullable="{ item }">
      <v-icon v-if="item.isNullable === 'YES'">check</v-icon>
    </template>

    </v-data-table>
  </v-container>
</template>

<script>
  const NO_INDEX = 'NO INDEX'
  const MULTIPLE_INDICES = 'MULTIPLE_INDICES'
  import ColumnDetail from './ColumnDetail.vue'
import { undefinedVarMessage } from 'graphql/validation/rules/NoUndefinedVariables';

  export default {
    name: 'TableColumns',
    props: {
      tableInfo: {
        type: Object,
        required: true
      }
    },
    components: {
      ColumnDetail
    },
    methods: {
      changeSort (column) {
        if (this.pagination.sortBy === column) {
          this.pagination.descending = !this.pagination.descending
        } else {
          this.pagination.sortBy = column
          this.pagination.descending = false
        }
      },
      fkIndexClass (fk) {
        const noIndexCount = fk.fkConstraintUsage.filter(cu => cu.fkIndexEvaluation === NO_INDEX).length
        const multiIndexCount = fk.fkConstraintUsage.filter(cu => cu.fkIndexEvaluation === MULTIPLE_INDICES).length

        return noIndexCount > 0 ? 'red' : (multiIndexCount > 0 ? 'yellow' : 'green')
      },
      uqIndexClass (uq) {
        const noIndexCount = uq.uqConstraintUsage.filter(cu => cu.uqIndexEvaluation === NO_INDEX).length
        const multiIndexCount = uq.uqConstraintUsage.filter(cu => cu.uqIndexEvaluation === MULTIPLE_INDICES).length

        return noIndexCount > 0 ? 'red' : (multiIndexCount > 0 ? 'yellow' : 'green')
      }
    },
    computed: {
      tableDetail () {
        console.log('table', this.tableInfo)
        // console.log('refs', JSON.stringify(this.tableInfo.referentialConstraints,null,2))
        // console.log('indices', JSON.stringify(this.tableInfo.indices,null,2))
        const pkColumns = this.tableInfo.primaryKeyConstraints.reduce(
          (pkCols, pkc) => {
            const cols = pkc.keyColumnUsage.reduce(
              (pkCols, kcu) => {
                return [...pkCols, kcu.columnName]
              }, []
            )
            return [...pkCols, ...cols]
          }, []
        )
        const retval = (this.tableInfo.tableColumns || [])
          .map(
            c => {
              const columnIndices = this.tableInfo.indices.filter(i => i.tableSchema === c.tableSchema && i.tableName === c.tableName && i.columnName === c.columnName)

              // primary keys
              const isPKColumn = pkColumns.indexOf(c.columnName) > -1 

              // foreign keys
              const fkConstraintUsage = this.$store.state.fkIndexEvaluations.singleColumn[`${c.tableSchema}.${c.tableName}.${c.columnName}`]

              // unique constraints
              const uqConstraintUsage = this.$store.state.uqIndexEvaluations[`${c.tableSchema}.${c.tableName}.${c.columnName}`]

              return {
                ...c
                ,fkConstraintUsage: fkConstraintUsage || []
                ,uqConstraintUsage: uqConstraintUsage || []
                ,isPKColumn: isPKColumn
                ,columnIndices: columnIndices
              }
            }
          )
          return retval
      },
    },
    data: () => ({
      headers: [
        {
          text: 'Ordinal',
          sortable: true,
          value: 'ordinalPosition'
        },
        {
          text: 'Column Name',
          sortable: true,
          value: 'columnName'
        },
        { 
          text: 'PK', 
          sortable: true,
          value: 'isPKColumn'
        },
        { 
          text: 'Nullable', 
          sortable: true,
          value: 'isNullable'
        },
        { 
          text: 'Data Type', 
          sortable: true,
          value: 'dataType'
        },
        { 
          text: 'Default Value', 
          sortable: true,
          value: 'columnDefault'
        },
      ],
      pagination: {
        sortBy: 'ordinalPosition',
        rowsPerPage: -1
      },
    })
  }
</script>

<style>

</style>
