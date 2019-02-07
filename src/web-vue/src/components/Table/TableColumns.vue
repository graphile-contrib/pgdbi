<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="tableColumns"
      class="elevation-1"
      :pagination.sync="pagination"
      :hide-actions="true"
    >
      <template slot="items" slot-scope="props">
        <td>{{ props.item.ordinalPosition }}</td>
        <td>{{ props.item.columnName }}</td>
        <td class="text-xs-right">{{ props.item.dataType }}</td>
        <td class="text-xs-right">{{ props.item.isIdentity }}</td>
        <td class="text-xs-right">{{ props.item.isNullable }}</td>
        <td class="text-xs-right">{{ props.item.columnDefault }}</td>
      </template>
    </v-data-table>
  </v-container>
</template>

<script>
  export default {
    name: 'TableColumns',
    props: {
      tableColumns: {
        type: Array,
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
    data: () => ({
      headers: [
        {
          text: 'Ordinal',
          align: 'left',
          sortable: true,
          value: 'ordinalPosition'
        },
        {
          text: 'Column Name',
          align: 'left',
          sortable: true,
          value: 'columnName'
        },
        { 
          text: 'Data Type', 
          align: 'right',
          sortable: true,
          value: 'dataType'
        },
        { 
          text: 'Identity', 
          align: 'right',
          sortable: true,
          value: 'isIdentity'
        },
        { 
          text: 'Nullable', 
          align: 'right',
          sortable: true,
          value: 'isNullable'
        },
        { 
          text: 'Default Value', 
          align: 'right',
          sortable: true,
          value: 'columnDefault'
        },
      ],
      pagination: {
        sortBy: 'ordinalPosition',
        rowsPerPage: -1
      },
    })
  }
</script>

<style>

</style>
