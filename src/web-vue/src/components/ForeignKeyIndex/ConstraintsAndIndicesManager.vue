<template>
  <v-card>
    <v-container bkeepground-color="blkeep">
      <v-tabs
        dark
        slider-color="yellow"
      >
        <v-tab
          v-for="schema in managedSchemata"
          :key="schema.schemaName"
          ripple
        >
          {{ schema.schemaName }}
        </v-tab>
        <v-tab-item
          v-for="schema in managedSchemata"
          :key="schema.schemaName"
        >
          <constraints-and-indices
            :tableSchema="schema.schemaName"
          >
          </constraints-and-indices>
        </v-tab-item>

        <v-tab
          key="allSchemata"
          ripple
        >
          All Schemata
        </v-tab>
        <v-tab-item
          key="allSchemata"
        >
          <constraints-and-indices
          >
          </constraints-and-indices>
        </v-tab-item>
      </v-tabs>
    </v-container>
  </v-card>
</template>

<script>
  // import FkIndexEvaluator from '@/components/ForeignKeyIndex/FkIndexEvaluator.vue'
  // import PolicyAssignmentDialog from '@/components/TableSecurity/TablePolicyAssignmentDialog'
  // import FkIndexTableManager from '@/components/ForeignKeyIndex/FkIndexTableManager.vue'
  import ConstraintsAndIndices from './ConstraintsAndIndices'

  // columnIndexStatus values
  const AS_EXPECTED = 'AS_EXPECTED'
  const NO_INDEX = 'NO_INDEX'
  const UNEXPECTED_NAME = 'UNEXPECTED_NAME'
  const EXTRA_INDEX = 'EXTRA_INDEX'

// columnIndexStatusColor values
  const AS_EXPECTED_COLOR = 'green'
  const NO_INDEX_COLOR = 'yellow'
  const UNEXPECTED_NAME_COLOR = 'blue'
  const EXTRA_INDEX_COLOR = 'red'
  
  export default {
    name: 'ConstraintsAndIndicesManager',
    components: {
      ConstraintsAndIndices
      // FkIndexTableManager
      // FkIndexEvaluator,
      // PolicyAssignmentDialog
    },
    methods: {
      columnIndexStatusColor (columnIndexStatus) {
        switch (columnIndexStatus) {
          case AS_EXPECTED:
            return AS_EXPECTED_COLOR
            break
          case NO_INDEX:
            return NO_INDEX_COLOR
            break
          case UNEXPECTED_NAME:
            return UNEXPECTED_NAME_COLOR
            break
          case EXTRA_INDEX:
            EXTRA_INDEX_COLOR
            break
        }
      }
    },
    watch: {
    },
    computed: {
      policies () {
        return this.$store.state.policies
      },
      managedSchemata () {
        return this.$store.state.managedSchemata
          .sort((a,b)=>{ return a.schemaName < b.schemaName ? -1 : 1})
      },
      // managedSchemata () {
      //   return this.$store.state.managedSchemata
      //     .map(
      //       schema => {
      //         return {
      //           ...schema,
      //           schemaTables: schema.schemaTables
      //             // .filter(t => t.name === 'order_info')// || t.name === 'order_line_item')
      //             .map(
      //               table => {
      //                 return {
      //                   ...table,
      //                   referentialConstraints: table.referentialConstraints.reduce(
      //                     (allRows, rc) => {
      //                       const columnName = rc.referencingColumnUsage[0].columnName
      //                       const indices = table.indices.filter(i => i.columnName === columnName)
      //                       const expectedIndexName = `idx_${rc.referencingColumnUsage[0].tableSchema}_${rc.referencingColumnUsage[0].tableName}_${rc.referencedColumnUsage[0].tableSchema}_${rc.referencedColumnUsage[0].tableName}`

      //                       switch (indices.length) {
      //                         case 0:
      //                           const statusMapEntry = this.statusMap.find(e => e.name === NO_INDEX)
      //                           return allRows.concat([{
      //                             ...rc,
      //                             columnName: columnName,
      //                             columnIndexStatus: NO_INDEX,
      //                             columnIndexStatusColor: NO_INDEX_COLOR,
      //                             indexName: 'NO INDEX',
      //                             expectedIndexName: expectedIndexName,
      //                             actions: statusMapEntry.defaultActions
      //                           }])
      //                           break
      //                         case 1:
      //                           const i = indices[0]
      //                           const nameIsUnexpected = i.indexName !== expectedIndexName
      //                           const statusMapEntryUnexpectedName = this.statusMap.find(e => e.name === UNEXPECTED_NAME)
      //                           const statusMapEntryAsExpected = this.statusMap.find(e => e.name === AS_EXPECTED)

      //                           return allRows.concat([{
      //                             ...rc,
      //                             columnName: columnName,
      //                             columnIndexStatus: nameIsUnexpected ? UNEXPECTED_NAME: AS_EXPECTED,
      //                             columnIndexStatusColor: nameIsUnexpected ? UNEXPECTED_NAME_COLOR : AS_EXPECTED_COLOR,
      //                             indexName: indices[0].indexName,
      //                             expectedIndexName: expectedIndexName,
      //                             actions: nameIsUnexpected ? statusMapEntryUnexpectedName.defaultActions : statusMapEntryAsExpected.defaultActions
      //                           }])
      //                           break
      //                         default:
      //                           return indices.reduce(
      //                             (allRows, i) => {
      //                               const nameIsExpected = i.indexName !== expectedIndexName
      //                               const statusMapEntryExtraIndex = this.statusMap.find(e => e.name === EXTRA_INDEX)
      //                               const statusMapEntryAsExpected = this.statusMap.find(e => e.name === AS_EXPECTED)

      //                               return allRows.concat([{
      //                                 ...rc,
      //                                 columnName: columnName,
      //                                 columnIndexStatus: nameIsExpected ? AS_EXPECTED : EXTRA_INDEX,
      //                                 columnIndexStatusColor: nameIsExpected ? AS_EXPECTED_COLOR :  EXTRA_INDEX_COLOR,
      //                                 indexName: i.indexName,
      //                                 expectedIndexName: expectedIndexName,
      //                                 actions: nameIsExpected ? statusMapEntryAsExpected.defaultActions : statusMapEntryExtraIndex.defaultActions
      //                               }])
      //                             }, []
      //                           )
      //                           break
      //                       }
      //                     }, []
      //                   )
      //                 }
      //               }
      //             )
      //             .map(
      //               table => {
      //                 return {
      //                   ...table,
      //                   sortedReferentialConstraints: this.statusMap.reduce(
      //                     (all, status) => {
      //                       const statusConstraints = table.referentialConstraints.filter(rc => rc.columnIndexStatus === status.name)

      //                       return {
      //                         ...all,
      //                         [status.name]: {
      //                           ...status, 
      //                           actions: Object.keys(status.defaultActions), 
      //                           referentialConstraints: statusConstraints,
      //                           referentialConstraintCount: statusConstraints.length,
      //                           columnIndexStatusColor: statusConstraints.length > 0 ? status.columnIndexStatusColor : 'grey'
      //                         }
      //                       }
      //                     }, {}
      //                   )
      //                 }
      //               }
      //             )
      //             .sort((a,b)=>{ return a.name < b.name ? -1 : 1})
      //         }
      //       }
      //     )
      //     .sort((a,b)=>{ return a.schemaName < b.schemaName ? -1 : 1})
      // },
      headers () {
        return [
          {
            text: '',
            sortable: false,
          },
          {
            text: 'Table Name',
            sortable: false,
          },
          ...this.statusMap.map(
            statusValue => {
              return {
                text: statusValue.name,
                sortable: false
              }
            }
          ),
        ]
      } 
    },
    data: () => ({
      mappedSchemata: [],
      statusMap: [
        {
          name: AS_EXPECTED,
          columnIndexStatusColor: AS_EXPECTED_COLOR,
          defaultActions: {}
        },
        {
          name: NO_INDEX,
          columnIndexStatusColor: NO_INDEX_COLOR,
          defaultActions: {
            ack: false,
            create: false,
          }
        },
        {
          name: UNEXPECTED_NAME,
          columnIndexStatusColor: UNEXPECTED_NAME_COLOR,
          defaultActions: {
            ack: false,
            rename: true,
          }
        },
        {
          name: EXTRA_INDEX,
          columnIndexStatusColor: EXTRA_INDEX_COLOR,
          defaultActions: {
            ack: false,
            drop: false,
          }
        }
      ]
    })
  }
</script>