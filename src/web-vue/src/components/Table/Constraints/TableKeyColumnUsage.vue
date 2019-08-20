<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="keyColumnUsage"
      class="elevation-1"
      :hide-default-footer="true"
    >
      <template slot="items" slot-scope="props">
        <td>{{ props.item.tableSchema }}</td>
        <td>{{ props.item.tableName }}</td>
        <td>{{ props.item.columnName }}</td>
      </template>
    </v-data-table>
  </v-container>
</template>

<script>
  export default {
    name: 'TableKeyColumnUsage',
    props: {
      keyColumnUsage: {
        type: Array,
        required: true
      }
    },
    methods: {
    },
    data: () => ({
      headers: [
        {
          text: 'Schema',
          align: 'left',
          sortable: false,
          value: 'tableSchema'
        },
        {
          text: 'Table',
          align: 'left',
          sortable: false,
          value: 'tableName'
        },
        {
          text: 'Column',
          align: 'left',
          sortable: false,
          value: 'columnName'
        },
      ]
    })
  }
</script>

<style>

</style>
