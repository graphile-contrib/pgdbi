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
    },
    data: () => ({
    })
  }
</script>