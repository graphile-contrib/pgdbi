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
          <view-columns
            :viewInfo="tableInfo"
          ></view-columns>
        </v-card>
      </v-tab-item>


    </v-tabs>
  </v-container>
</template>

<script>
  // import tableById from '../../gql/query/tableById.graphql';
  import ViewColumns from './ViewColumns.vue'

  export default {
    name: 'DbView',
    components: {
      ViewColumns,
    },
    props: {
      id: {
        type: String,
        required: true
      }
    },
    computed: {
      tableInfo () {
        const schema = this.$store.state.managedSchemata.find(s => s.schemaName === this.tableSchema)
        const table = schema.schemaTables.find(t => t.tableName === this.tableName)

        return {
          ...table
        }
      },
      tableName () {
        return this.id.split('.')[1]
      },
      tableSchema () {
        return this.id.split('.')[0]
      },
      tableColumns () {
        return this.tableInfo.tableColumns || []
      },
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
      // console.log('to', to)
      // console.log('from', from)
      next()
    },
  }
</script>

<style>

</style>
