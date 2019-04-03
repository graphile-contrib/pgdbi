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
          <v-data-table
            :headers="headers"
            :items="schema.schemaTables"
            :hide-actions="true"
          >
            <template slot="items" slot-scope="props">
              <tr @click="props.expanded = !props.expanded">
                <td>      
                  <v-btn icon @click.stop="props.expanded = !props.expanded">
                    <v-icon>{{ props.expanded ? 'expand_less' : 'expand_more' }}</v-icon>
                  </v-btn>
                </td>
                <td>{{ props.item.name }}</td>
                <!-- <td>{{ props.item.policyDefinition.name }}</td> -->
                <!-- <td><policy-assignment-dialog :currentPolicyDefinition="props.item.policyDefinition" :table="props.item"></policy-assignment-dialog></td> -->
              </tr>
            </template>

            <template slot="expand" slot-scope="props">
              <fk-index-table-manager
                :key="props.item.id"
                :table="props.item"
              ></fk-index-table-manager>
              <!-- <fk-index-evaluator
                :table="props.item"
              ></fk-index-evaluator> -->
            </template>
          </v-data-table>
        </v-tab-item>
      </v-tabs>
    </v-container>
  </v-card>
</template>

<script>
  // import FkIndexEvaluator from '@/components/ForeignKeyIndex/FkIndexEvaluator.vue'
  // import PolicyAssignmentDialog from '@/components/TableSecurity/TablePolicyAssignmentDialog'
  import FkIndexTableManager from '@/components/ForeignKeyIndex/FkIndexTableManager.vue'

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
    name: 'ForeignKeyIndexManager',
    components: {
      FkIndexTableManager
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
          .map(
            schema => {
              return {
                ...schema,
                schemaTables: schema.schemaTables
                  // .filter(t => t.name === 'order_info' || t.name === 'order_line_item')
                  .map(
                    table => {
                      return {
                        ...table,
                        referentialConstraints: table.referentialConstraints.reduce(
                          (allRows, rc) => {
                            const columnName = rc.referencingColumnUsage[0].columnName
                            const indices = table.indices.filter(i => i.columnName === columnName)
                            const expectedIndexName = `idx_${rc.referencingColumnUsage[0].tableSchema}_${rc.referencingColumnUsage[0].tableName}_${rc.referencedColumnUsage[0].tableSchema}_${rc.referencedColumnUsage[0].tableName}`

                            switch (indices.length) {
                              case 0:
                                return allRows.concat([{
                                  ...rc,
                                  columnName: columnName,
                                  columnIndexStatus: NO_INDEX,
                                  columnIndexStatusColor: NO_INDEX_COLOR,
                                  indexName: 'NO INDEX',
                                  actions: {
                                    ack: false,
                                    create: false,
                                  }
                                }])
                                break
                              case 1:
                                const i = indices[0]
                                const nameIsUnexpected = i.indexName !== expectedIndexName

                                return allRows.concat([{
                                  ...rc,
                                  columnName: columnName,
                                  columnIndexStatus: nameIsUnexpected ? UNEXPECTED_NAME: AS_EXPECTED,
                                  columnIndexStatusColor: nameIsUnexpected ? UNEXPECTED_NAME_COLOR : AS_EXPECTED_COLOR,
                                  indexName: indices[0].indexName,
                                  expectedIndexName: expectedIndexName,
                                  actions: nameIsUnexpected ? {
                                    ack: false,
                                    rename: true,
                                  } : {}
                                }])
                                break
                              default:
                                return indices.reduce(
                                  (allRows, i) => {
                                    console.log('rc', rc)
                                    const nameIsExpected = i.indexName !== expectedIndexName

                                    return allRows.concat([{
                                      ...rc,
                                      columnName: columnName,
                                      columnIndexStatus: nameIsExpected ? AS_EXPECTED : EXTRA_INDEX,
                                      columnIndexStatusColor: nameIsExpected ? AS_EXPECTED_COLOR :  EXTRA_INDEX_COLOR,
                                      indexName: i.indexName,
                                      expectedIndexName: expectedIndexName,
                                      actions: nameIsExpected ? {} : {
                                        ack: false,
                                        drop: false,
                                      }
                                    }])
                                  }, []
                                )
                                break
                            }
                          }, []
                        )
                      }
                    }
                  )
                  .sort((a,b)=>{ return a.name < b.name ? -1 : 1})
              }
            }
          )
          .sort((a,b)=>{ return a.schemaName < b.schemaName ? -1 : 1})
      },
    },
    data: () => ({
      mappedSchemata: [],
      headers: [
        {
          text: '',
          sortable: false,
        },
        {
          text: 'Table Name',
          sortable: false,
        },
        {
          text: 'WHAT COL',
          sortable: false,
        },
      ]
    })
  }
</script>