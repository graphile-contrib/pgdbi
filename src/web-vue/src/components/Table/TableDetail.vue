<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="tableDetail"
      class="elevation-1"
      hide-default-footer
      show-expand
    >
    <template v-slot:item.fkInfo="{ item }">
      {{ item.fkInfo }}
    </template>

    <template v-slot:item.fkIndex="{ item }">
      <div :class="fkIndexClass(item.fkIndex)">
        <router-link :to="{ name: 'table', params: { id: item.fkIndexLinkId }}" target="_blank" v-if="item.fkIndexLinkId">{{item.fkIndex}}</router-link>
        <span v-if="!item.fkIndexLinkId">{{item.fkIndex}}</span>
      </div>
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

  export default {
    name: 'TableDetail',
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
        const retval = (this.tableInfo.tableColumns || [])
          .map(
            c => {
              const fkConstraintUsage = ((this.tableInfo.referentialConstraints || [])
                .find(
                  rc => {
                    return rc.referencingColumnUsage.find(rcu => rcu.tableSchema === c.tableSchema && rcu.tableName === c.tableName && rcu.columnName === c.columnName) !== undefined
                  }
                ) || {referencedColumnUsage: []}).referencedColumnUsage[0]
                // ) || {referencingColumnUsage: []}).referencingColumnUsage.find(rcu => rcu.tableSchema === c.tableSchema && rcu.tableName === c.tableName && rcu.columnName === c.columnName)

              const fkInfo = !fkConstraintUsage ? '' : `${fkConstraintUsage.tableSchema}.${fkConstraintUsage.tableName}.${fkConstraintUsage.columnName}`

              const fkIndex = this.tableInfo.indices
                .find(i => i.tableSchema === c.tableSchema && i.tableName === c.tableName && i.columnName === c.columnName)

              const fkIndexEvaluation = !fkConstraintUsage ? '' : (!fkIndex ? NO_INDEX : `${fkIndex.indexName}`)

              const fkIndexLinkId = !fkConstraintUsage || fkIndexEvaluation === NO_INDEX ? '' : `table:${fkConstraintUsage.tableSchema}.${fkConstraintUsage.tableName}`

              return {
                ...c
                ,fkInfo: fkInfo
                ,fkIndex: fkIndexEvaluation
                ,fkIndexLinkId: fkIndexLinkId
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
          text: 'Data Type', 
          sortable: true,
          value: 'dataType'
        },
        { 
          text: 'Identity', 
          sortable: true,
          value: 'isIdentity'
        },
        { 
          text: 'Nullable', 
          sortable: true,
          value: 'isNullable'
        },
        { 
          text: 'Default Value', 
          sortable: true,
          value: 'columnDefault'
        },
        { 
          text: 'FK Reference', 
          sortable: true,
          value: 'fkInfo'
        },
        { 
          text: 'FK Index', 
          sortable: true,
          value: 'fkIndex'
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
