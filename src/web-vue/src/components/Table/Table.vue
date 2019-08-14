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
  // import tableById from '../../gql/query/tableById.graphql';
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
      tableInfo () {
        const schemaName = this.id.split(':')[1].split('.')[0]
        const tableName = this.id.split(':')[1].split('.')[1]
        const schema = this.$store.state.managedSchemata.find(s => s.schemaName === schemaName)
        return schema.schemaTables.find(t => t.tableName === tableName)
      },
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
      // tableInfo: {},
    }),
    beforeRouteUpdate (to, from, next) {
      // called when the route that renders this component has changed,
      // but this component is reused in the new route.
      // For example, for a route with dynamic params `/foo/:id`, when we
      // navigate between `/foo/1` and `/foo/2`, the same `Foo` component instance
      // will be reused, and this hook will be called when that happens.
      // has access to `this` component instance.
      console.log('to', to)
      console.log('from', from)
      next()
    },
    // mounted () {
    //   const schemaName = this.id.split(':')[1].split('.')[0]
    //   const tableName = this.id.split(':')[1].split('.')[1]
    //   const schema = this.$store.state.managedSchemata.find(s => s.schemaName === schemaName)
    //   this.tableInfo = schema.schemaTables.find(t => t.tableName === tableName)
    // }
  }
</script>

<style>

</style>
