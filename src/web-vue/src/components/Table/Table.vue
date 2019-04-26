<template>
  <v-container>
    <h1>{{ id }}</h1>
    <hr/>
    <v-tabs
      v-model="activeTab"
      dark
    >
      <v-tab
        key="cols"
        ripple
      >
        Columns
      </v-tab>
      <v-tab-item
        key="cols"
      >
        <v-card flat>
          <table-columns
            :tableColumns="tableColumns"
          ></table-columns>
        </v-card>
      </v-tab-item>

      <v-tab
        key="constraints"
        ripple
      >
        Constraints
      </v-tab>
      <v-tab-item
        key="constraints"
      >
        <v-card flat>
          <table-constraints
            :tableInfo="tableInfo"
          ></table-constraints>
        </v-card>
      </v-tab-item>

      <v-tab
        key="indices"
        ripple
      >
        Indices
      </v-tab>
      <v-tab-item
        key="indices"
      >
        <v-card flat>
          <table-indices
            :indices="indices"
          ></table-indices>
        </v-card>
      </v-tab-item>

      <v-tab
        key="tablegrants"
        ripple
      >
        Table Grants
      </v-tab>
      <v-tab-item
        key="tablegrants"
      >
        <v-card flat>
          <table-grants
            :grants="tableGrants"
          ></table-grants>
        </v-card>
      </v-tab-item>

      <v-tab
        key="tablecolumngrants"
        ripple
      >
        Column Grants
      </v-tab>
      <v-tab-item
        key="tablecolumngrants"
      >
        <v-card flat>
          <table-column-grants
            :grants="tableColumnGrants"
          ></table-column-grants>
        </v-card>
      </v-tab-item>

      <v-tab
        key="tablepolicies"
        ripple
      >
        Policies
      </v-tab>
      <v-tab-item
        key="tablepolicies"
      >
        <v-card flat>
          <table-policies
            :policies="tablePolicies"
          ></table-policies>
        </v-card>
      </v-tab-item>

      <v-tab
        key="tabletriggers"
        ripple
      >
        Triggers
      </v-tab>
      <v-tab-item
        key="tabletriggers"
      >
        <v-card flat>
          <table-triggers
            :triggers="tableTriggers"
          ></table-triggers>
        </v-card>
      </v-tab-item>

    </v-tabs>
  </v-container>
</template>

<script>
  import tableById from '../../gql/query/tableById.graphql';
  import TableColumns from './TableColumns.vue'
  import TableIndices from './TableIndices.vue'
  import TableConstraints from './TableConstraints.vue'
  import TableGrants from './TableGrants.vue'
  import TableColumnGrants from './TableColumnGrants.vue'
  import TablePolicies from './TablePolicies.vue'
  import TableTriggers from './TableTriggers.vue'

  export default {
    name: 'Table',
    components: {
      TableColumns,
      TableConstraints,
      TableIndices,
      TableGrants,
      TableColumnGrants,
      TablePolicies,
      TableTriggers
    },
    props: {
      id: {
        type: String,
        required: true
      }
    },
    computed: {
      tableName () {
        return this.tableInfo.tableName || 'N/A'
      },
      tableSchema () {
        return (this.tableInfo.id || 'N/A:N/A.N/A').split(':')[1].split('.')[0]
      },
      tableColumns () {
        return this.tableInfo.tableColumns || []
      },
      indices () {
        return this.tableInfo.indices || []
      },
      tableGrants () {
        return this.tableInfo.roleTableGrants || []
      },
      tableColumnGrants () {
        return this.tableInfo.roleColumnGrants || []
      },
      tablePolicies () {
        return this.tableInfo.policies || []
      },
      tableTriggers () {
        return this.tableInfo.triggers || []
      }
    },
    methods: {
    },
    data: () => ({
      activeTab: null,
      tableInfo: {},
    }),
    apollo: {
      init: {
        query: tableById,
        variables () {
          return {
            id: this.id
          }
        },
        update (result) {
          console.log('table', result)
          this.tableInfo = result.tableById
        }
      }
    }
  }
</script>

<style>

</style>
