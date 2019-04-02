<template>
  <v-card>
    <v-container background-color="black">
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
  const AS_CALCULATED = 'AS_CALCULATED'
  const NO_INDEX = 'NO_INDEX'
  const UNEXPECTED_NAME = 'UNEXPECTED_NAME'
  const EXTRA_INDEX = 'EXTRA_INDEX'

// columnIndexStatusColor values
  const AS_CALCULATED_COLOR = 'green'
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
          case AS_CALCULATED:
            return AS_CALCULATED_COLOR
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
                            switch (indices.length) {
                              case 0:
                                return allRows.concat([{
                                  ...rc,
                                  columnName: columnName,
                                  columnIndexStatus: NO_INDEX,
                                  columnIndexStatusColor: NO_INDEX_COLOR
                                }])
                                break
                              case 1:
                                const i = indices[0]
                                return allRows.concat([{
                                  ...rc,
                                  columnName: columnName,
                                  columnIndexStatus: AS_CALCULATED,
                                  columnIndexStatusColor: AS_CALCULATED_COLOR
                                }])
                                break
                              default:
                                return indices.reduce(
                                  (allRows, i) => {
                                    return allRows.concat([{
                                      ...rc,
                                      columnName: columnName,
                                      columnIndexStatus: EXTRA_INDEX,
                                      columnIndexStatusColor: EXTRA_INDEX_COLOR
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