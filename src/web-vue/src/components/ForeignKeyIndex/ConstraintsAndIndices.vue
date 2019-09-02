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
      <!-- 
      <v-tab
        key="chk"
        ripple
      >
        Check Constraints
      </v-tab>
      <v-tab-item
        key="chk"
      >
        <v-card flat>
          <table-check-constraints
            :checkConstraints="checkConstraints"
          ></table-check-constraints>
        </v-card>
      </v-tab-item> -->
    </v-tabs>
</template>

<script>
  import GenericIndexSet from './GenericIndexSet'
  import FkIndexConstraints from './FkIndexConstraints'
  import UqIndexSet from './UqIndexSet'
  // import TableCheckConstraints from './Constraints/TableCheckConstraints.vue'

  export default {
    name: 'ConstraintsAndIndices',
    components: {
      GenericIndexSet,
      FkIndexConstraints,
      UqIndexSet,
      // TableCheckConstraints
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
          singleColumn: Object.values(all.singleColumn).filter(
            e => {
              const fkidx = e[0] || {}
              return this.tableName ?  fkidx.tableName === this.tableName : true
            }
          ),
          multiColumn: Object.values(all.multiColumn).filter(
            e => {
              const fkidx = e[0] || {}
              return this.tableName ?  fkidx.tableName === this.tableName : true
            }
          )
        } : schemaFiltered

        return tableFiltered
      },
      uqIndexEvaluations () {
        return this.$store.state.uqIndexEvaluations
      },
      checkConstraints () {
        // return this.tableInfo.checkConstraints || []
      },
    },
    data: () => ({
      activeTab: 0
    })
  }
</script>

<style>

</style>
