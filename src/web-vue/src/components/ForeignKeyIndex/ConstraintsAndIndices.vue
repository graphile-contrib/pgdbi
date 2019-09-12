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
        Create Indices Script
      </v-tab>
      <v-tab-item
        key="drop"
      >
        <v-card flat>
          <script-viewer
            :scriptText="createIndicesScript"
            skipFormat
          ></script-viewer>
        </v-card>
      </v-tab-item>

      <v-tab
        key="create"
        ripple
      >
        Drop Indices Script
      </v-tab>
      <v-tab-item
        key="create"
      >
        <v-card flat>
          <script-viewer
            :scriptText="dropIndicesScript"
          ></script-viewer>
        </v-card>
      </v-tab-item>
    </v-tabs>
</template>

<script>
  import GenericIndexSet from './GenericIndexSet'
  import FkIndexConstraints from './FkIndexConstraints'
  import UqIndexSet from './UqIndexSet'
  import CheckConstraints from './Constraints/CheckConstraints.vue'
  import ScriptViewer from '@/components/_common/ScriptViewer'

  export default {
    name: 'ConstraintsAndIndices',
    components: {
      GenericIndexSet,
      FkIndexConstraints,
      UqIndexSet,
      CheckConstraints,
      ScriptViewer
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
          // .sort(
          //   (a,b) => {
          //     if (a.schemaName < b.schemaName) { return -1 }
          //     if (a.schemaName > b.schemaName) { return 1 }
          //     if (a.tableName < b.tableName) { return -1 }
          //     if (a.tableName > b.tableName) { return 1 }

          //   }
          // )
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
      createIndicesScript () {
        const singleColumnFkIndices = Object.values(this.$store.state.fkIndexEvaluations.singleColumn)
          .filter(e => e.length > 0)
          .filter(e => this.tableName ? this.tableName === e[0].tableName : true)
          .filter(e => this.tableSchema ? this.tableSchema === e[0].tableSchema : true)
          .map(e => e[0])

        const multiColumnFkIndices = Object.values(this.$store.state.fkIndexEvaluations.multiColumn)
          .filter(e => e.length > 0)
          .filter(e => this.tableName ? this.tableName === e[0].tableName : true)
          .filter(e => this.tableSchema ? this.tableSchema === e[0].tableSchema : true)
          // .map(e => e[0])

        const singleColumnUqIndices = Object.values(this.$store.state.uqIndexEvaluations.singleColumn)
          .filter(e => e.length > 0)
          .filter(e => this.tableName ? this.tableName === e[0].tableName : true)
          .filter(e => this.tableSchema ? this.tableSchema === e[0].tableSchema : true)
          .map(e => e[0])

        const multiColumnUqIndices = Object.values(this.$store.state.uqIndexEvaluations.multiColumn)
          .filter(e => e.length > 0)
          .filter(e => this.tableName ? this.tableName === e[0].tableName : true)
          .filter(e => this.tableSchema ? this.tableSchema === e[0].tableSchema : true)
          // .map(e => e[0])

        const fkAndUqIndices = [
          ...singleColumnFkIndices
          ,...multiColumnFkIndices
          ,...singleColumnUqIndices
          ,...multiColumnUqIndices
        ].flat()


        const singleColumnGenericIndices = Object.values(this.$store.state.genericIndexEvaluations)
          .filter(e => e.idxColumns.length === 1)
          // .filter(e => e.length > 0)
          .filter(e => fkAndUqIndices.filter(i => i.id === e.id).length === 0)
          .filter(e => this.tableName ? this.tableName === e.tableName : true)
          .filter(e => this.tableSchema ? this.tableSchema === e.tableSchema : true)

          console.log('singleColumnGenericIndices', singleColumnGenericIndices)

        // const multiColumnFkIndices = Object.values(this.$store.state.fkIndexEvaluations.multiColumn)
        //   .filter(e => e.length > 0)
        //   .filter(e => this.tableName ? this.tableName === e[0].tableName : true)
        //   .filter(e => this.tableSchema ? this.tableSchema === e[0].tableSchema : true)
        //   // .map(e => e[0])

        const allIndices = [
          ...fkAndUqIndices,
          ...singleColumnGenericIndices
        ].flat()

        console.log(allIndices)
        const blah = allIndices.filter(i => i.desiredRealization.create.indexOf('sink_uq_single_column_key') > -1)

        console.log(JSON.stringify(blah.map(i => Object.keys(i)), null,2))
        console.log(JSON.stringify(blah
          .map(
            i => {
              return {
                id: i.id
                ,idxKey: i.idxKey
                ,uqPath: i.uqPath
                ,idxColumns: i.idxColumns
              }}
          ), null,2
        ))

        return allIndices.reduce(
          (all, e) => {
// console.log('e)', e)
            return e.desiredRealization.create ? all.concat(`${e.desiredRealization.create}\n`) : all
          }, ''
        )        

        // return Object.values(this.$store.state.genericIndexEvaluations).reduce(
        //   (all, e) => {
        //     if (this.tableName && this.tableName !== e.tableName) { return all }
        //     if (this.schemaName && this.tableSchema !== e.tableSchema) { return all }

        //     return e.desiredRealization.create ? all.concat(e.desiredRealization.create) : all
        //   }, ''
        // )
      },
      dropIndicesScript () {
        return Object.values(this.$store.state.fkIndexEvaluations.singleColumn).reduce(
          (all, fkIndexEvaluation) => {
            const e = fkIndexEvaluation[0]

            if (this.tableName && this.tableName !== e.tableName) { return all }
            if (this.schemaName && this.tableSchema !== e.tableSchema) { return all }

            return e.desiredRealization.drop ? all.concat(e.desiredRealization.drop) : all
          }, ''
        )

        // return Object.values(this.$store.state.genericIndexEvaluations).reduce(
        //   (all, e) => {
        //     if (this.tableName && this.tableName !== e.tableName) { return all }
        //     if (this.schemaName && this.tableSchema !== e.tableSchema) { return all }

        //     return e.desiredRealization.drop ? all.concat(e.desiredRealization.drop) : all
        //   }, ''
        // )
      }
    },
    data: () => ({
      activeTab: 0
    })
  }
</script>

<style>

</style>
