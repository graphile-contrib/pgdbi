<template>
    <v-tabs
      v-model="activeTab"
      dark
    >
      <v-tab
        key="allIndices"
        ripple
      >
        All Indices
      </v-tab>
      <v-tab-item
        key="allIndices"
      >
        <v-card flat>
          <generic-index-set
            :indexEvaluations="allIndexEvaluations"
          ></generic-index-set>
        </v-card>
      </v-tab-item>
      <v-tab
        key="fkIndices"
        ripple
      >
        Foreign Key Constraints
      </v-tab>
      <v-tab-item
        key="fkIndices"
      >
        <v-card flat>
          <fk-index-constraints
            :fkIndexEvaluations="fkIndexEvaluations"
          ></fk-index-constraints>
        </v-card>
      </v-tab-item>
      <v-tab
        key="uqIndices"
        ripple
      >
        Unique Constraints
      </v-tab>
      <v-tab-item
        key="uqIndices"
      >
        <v-card flat>
          <uq-index-set
            :uqIndexEvaluations="uqIndexEvaluations"
          ></uq-index-set>
        </v-card>
      </v-tab-item>
      
      <v-tab
        key="chk"
        ripple
        :hidden="hideCheckConstraints"
      >
        Check Constraints
      </v-tab>
      <v-tab-item
        key="chk"
      >
        <v-card flat>
          <check-constraints
            :checkConstraints="checkConstraints"
          ></check-constraints>
        </v-card>
      </v-tab-item>

      <v-tab
        key="drop"
        ripple
      >
        Drop Indices Script
      </v-tab>
      <v-tab-item
        key="drop"
      >
        <v-card flat>
          <drop-indices-script
            :indicesToDrop="indicesToDrop"
          ></drop-indices-script>
        </v-card>
      </v-tab-item>
    </v-tabs>
</template>

<script>
  import GenericIndexSet from './GenericIndexSet'
  import FkIndexConstraints from './FkIndexConstraints'
  import UqIndexSet from './UqIndexSet'
  import CheckConstraints from './Constraints/CheckConstraints.vue'
  import DropIndicesScript from './DropIndicesScript'

  export default {
    name: 'ConstraintsAndIndices',
    components: {
      GenericIndexSet,
      FkIndexConstraints,
      UqIndexSet,
      CheckConstraints,
      DropIndicesScript
    },
    props: {
      tableSchema: {
        type: String,
        required: false
      },
      tableName: {
        type: String,
        required: false
      }
    },
    methods: {
    },
    computed: {
      allIndexEvaluations () {
        const all = Object.values(this.$store.state.genericIndexEvaluations)
        const schemaFiltered = this.tableSchema ? all.filter(e => e.tableKey.split('.')[0] === this.tableSchema) : all
        const tableFiltered = this.tableName ? all.filter(e => e.tableKey.split('.')[0] === this.tableSchema && e.tableKey.split('.')[1] === this.tableName) : schemaFiltered
        return tableFiltered
      },
      fkIndexEvaluations () {
        const all = this.$store.state.fkIndexEvaluations 

        const schemaFiltered = this.tableSchema ? {
          singleColumn: Object.values(all.singleColumn).filter(
            e => {
              const fkidx = e[0] || {}
              return this.tableSchema ?  fkidx.tableSchema === this.tableSchema : true
            }
          ),
          multiColumn: Object.values(all.multiColumn).filter(
            e => {
              const fkidx = e[0] || {}
              return this.tableSchema ?  fkidx.tableSchema === this.tableSchema : true
            }
          )
        } : all

        const tableFiltered = this.tableName ? {
          singleColumn: Object.values(schemaFiltered.singleColumn).filter(
            e => {
              const fkidx = e[0] || {}
              return this.tableName ?  fkidx.tableName === this.tableName : true
            }
          ),
          multiColumn: Object.values(schemaFiltered.multiColumn).filter(
            e => {
              const fkidx = e[0] || {}
              return this.tableName ?  fkidx.tableName === this.tableName : true
            }
          )
        } : schemaFiltered

        return tableFiltered
      },
      uqIndexEvaluations () {
        const all = this.$store.state.uqIndexEvaluations

        const schemaFiltered = this.tableSchema ? {
          singleColumn: Object.values(all.singleColumn).filter(
            e => {
              const fkidx = e[0] || {}
              return this.tableSchema ?  fkidx.tableSchema === this.tableSchema : true
            }
          ),
          multiColumn: Object.values(all.multiColumn).filter(
            e => {
              const fkidx = e[0] || {}
              return this.tableSchema ?  fkidx.tableSchema === this.tableSchema : true
            }
          )
        } : all

        const tableFiltered = this.tableName ? {
          singleColumn: Object.values(schemaFiltered.singleColumn).filter(
            e => {
              const fkidx = e[0] || {}
              return this.tableName ?  fkidx.tableName === this.tableName : true
            }
          ),
          multiColumn: Object.values(schemaFiltered.multiColumn).filter(
            e => {
              const fkidx = e[0] || {}
              return this.tableName ?  fkidx.tableName === this.tableName : true
            }
          )
        } : schemaFiltered

        return tableFiltered
      },
      hideCheckConstraints () {
        return this.tableName === null || this.tableName === undefined
      },
      checkConstraints () {
        if (this.tableSchema && this.tableName) {
          return this.$store.state.managedSchemata.find(s => s.schemaName === this.tableSchema).schemaTables.find(t => t.tableName === this.tableName).checkConstraints
        } else {
          return []
        }
      },
      indicesToDrop () {
        const all = this.$store.state.indicesToDrop

        const schemaFiltered = this.tableSchema ? Object.values(all).filter(
            e => {
              return this.tableSchema ?  e.tableSchema === this.tableSchema : true
            }
          ) : all

        const tableFiltered = this.tableName ? Object.values(schemaFiltered).filter(
            e => {
              return this.tableName ?  e.tableName === this.tableName : true
            }
          ) : schemaFiltered

        return Object.values(tableFiltered)
      }
    },
    data: () => ({
      activeTab: 0
    })
  }
</script>

<style>

</style>
