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
          <table-generic-indices
            :indices="allIndices"
          ></table-generic-indices>
        </v-card>
      </v-tab-item>
      <v-tab
        key="fkIndices"
        ripple
      >
        Foreign Key Indices
      </v-tab>
      <v-tab-item
        key="fkIndices"
      >
        <v-card flat>
          <table-fk-indices
            :fkIndices="fkIndices"
          ></table-fk-indices>
        </v-card>
      </v-tab-item>
      <v-tab
        key="uqIndices"
        ripple
      >
        Unique Indices
      </v-tab>
      <v-tab-item
        key="uqIndices"
      >
        <v-card flat>
          <table-uq-indices
            :uqIndices="uqIndices"
          ></table-uq-indices>
        </v-card>
      </v-tab-item>
    </v-tabs>
</template>

<script>
  import TableGenericIndices from './TableGenericIndices'
  import TableFkIndices from './TableFkIndices'
  import TableUqIndices from './TableUqIndices'

  export default {
    name: 'TableIndexAnalysis',
    components: {
      TableGenericIndices,
      TableFkIndices,
      TableUqIndices
    },
    props: {
      tableInfo: {
        type: Object,
        required: true
      }
    },
    methods: {
      changeSort (column) {
        if (this.pagination.sortBy === column) {
          this.pagination.descending = !this.pagination.descending
        } else {
          this.pagination.sortBy = column
          this.pagination.descending = false
        }
      }
    },
    computed: {
      allIndices () {
        return this.tableInfo.indices
      },
      fkIndices () {
        return this.tableInfo.indices
      },
      uqIndices () {
        return this.tableInfo.indices
      }
    },
    data: () => ({
      activeTab: 0,
      headers: [
        {
          text: 'Column',
          value: 'columnName'
        },
        {
          text: 'Index Name',
          value: 'indexName'
        },
      ],
      pagination: {
        sortBy: 'constraintName',
        rowsPerPage: -1
      },
    })
  }
</script>

<style>

</style>
