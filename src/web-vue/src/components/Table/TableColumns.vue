<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="tableDetail"
      class="elevation-1 text-no-wrap"
      hide-default-footer
      show-expand
      dense
    >
    <template v-slot:item.isPKColumn="{ item }">
        {{ item.isPKColumn ? 'YES' : '' }}
    </template>

    <template v-slot:item.fkInfo="{ item }">
        <span v-if="item.fkInfo"><router-link :to="{ name: 'table', params: { id: item.fkTableLinkId }}" target="_blank" v-if="item.fkTableLinkId">{{item.fkInfo}}</router-link>
        <hr>
        Index: <span :class="fkIndexClass(item.fkIndex)">{{item.fkIndex}}</span></span>
    </template>

    <template slot="expanded-item" slot-scope="props">
      <td :colspan="headers.length + 1">
        <column-detail
          :columnInfo="props.item"
        ></column-detail>
      </td>
    </template>

    </v-data-table>
  </v-container>
</template>

<script>
  const NO_INDEX = 'NO INDEX'
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
      fkIndexClass (text) {
        return text === NO_INDEX ? 'red--text' : ''
      }
    },
    computed: {
      tableDetail () {
        console.log('table', this.tableInfo)
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
              // primary keys
              const isPKColumn = pkColumns.indexOf(c.columnName) > -1 

              // foreign keys
              const fkConstraintUsage = ((this.tableInfo.referentialConstraints || [])
                .find(
                  rc => {
                    return rc.referencingColumnUsage.find(rcu => rcu.tableSchema === c.tableSchema && rcu.tableName === c.tableName && rcu.columnName === c.columnName) !== undefined
                  }
                ) || {referencedColumnUsage: []}).referencedColumnUsage[0]
              const fkInfo = !fkConstraintUsage ? '' : `${fkConstraintUsage.tableSchema}.${fkConstraintUsage.tableName}.${fkConstraintUsage.columnName}`
              const fkIndex = this.tableInfo.indices.find(i => i.tableSchema === c.tableSchema && i.tableName === c.tableName && i.columnName === c.columnName)
              const fkIndexEvaluation = !fkConstraintUsage ? '' : (!fkIndex ? NO_INDEX : `${fkIndex.indexName}`)
              const fkTableLinkId = !fkConstraintUsage ? '' : `table:${fkConstraintUsage.tableSchema}.${fkConstraintUsage.tableName}`

              return {
                ...c
                ,fkInfo: fkInfo
                ,fkIndex: fkIndexEvaluation
                ,fkTableLinkId: fkTableLinkId
                ,isPKColumn: isPKColumn
              }
            }
          )
          console.log('tableDetail', retval)
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
          text: 'Data Type', 
          sortable: true,
          value: 'dataType'
        },
        // { 
        //   text: 'Identity', 
        //   sortable: true,
        //   value: 'isIdentity'
        // },
        { 
          text: 'Nullable', 
          sortable: true,
          value: 'isNullable'
        },
        { 
          text: 'PK Column', 
          sortable: true,
          value: 'isPKColumn'
        },
        { 
          text: 'FK Reference', 
          sortable: true,
          value: 'fkInfo'
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
