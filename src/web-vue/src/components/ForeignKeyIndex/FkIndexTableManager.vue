<template>
  <v-card>
    <v-container background-color="black">
      <v-tabs
        dark
        slider-color="yellow"
      >
        <v-tab
          key="policy"
          ripple
        >
          policy
        </v-tab>
        <v-tab-item
          key="policy"
        >
          <fk-index-evaluator
            :table="table"
          ></fk-index-evaluator>
        </v-tab-item>

        <v-tab
          key="indices"
          ripple
        >
          indices
        </v-tab>
        <v-tab-item
          key="indices"
        >
          <table-indices
            :indices="indices"
          ></table-indices>
        </v-tab-item>

        <v-tab
          key="constraints"
          ripple
        >
          foreign keys
        </v-tab>
        <v-tab-item
          key="constraints"
        >
          <table-referential-constraints
            :referentialConstraints="referentialConstraints"
          ></table-referential-constraints>
        </v-tab-item>
      </v-tabs>
    </v-container>
  </v-card>
</template>

<script>
  import FkIndexEvaluator from '@/components/ForeignKeyIndex/FkIndexEvaluator.vue'
  import TableReferentialConstraints from '@/components/Table/Constraints/TableReferentialConstraints.vue'
  import TableIndices from '@/components/Table/TableIndices.vue'

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
    name: 'FkIndexTableManager',
    components: {
      FkIndexEvaluator,
      TableIndices,
      TableReferentialConstraints
    },
    props: {
      table: {
        type: Object,
        required: true
      }
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
      referentialConstraints () {
        return this.table.referentialConstraints || []
      },
      indices () {
        return this.table.indices || []
      },
      policies () {
        return this.$store.state.policies
      },
      managedSchemata () {
        return this.$store.state.managedSchemata
          .map(
            schema => {
              return {
                ...schema,
                schemaTables: schema.schemaTables.map(
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
                                columnName: columnName,
                                constraintName: rc.constraintName,
                                columnIndexStatus: NO_INDEX,
                                columnIndexStatusColor: NO_INDEX_COLOR
                              }])
                              break
                            case 1:
                              const i = indices[0]
                              return allRows.concat([{
                                columnName: columnName,
                                constraintName: rc.constraintName,
                                columnIndexStatus: AS_CALCULATED,
                                columnIndexStatusColor: AS_CALCULATED_COLOR
                              }])
                              break
                            default:
                              return indices.reduce(
                                (allRows, i) => {
                                  return allRows.concat([{
                                    columnName: columnName,
                                    constraintName: rc.constraintName,
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
                  })
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