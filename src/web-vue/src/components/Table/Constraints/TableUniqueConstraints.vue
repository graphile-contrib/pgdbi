<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="uniqueConstraints"
      class="elevation-1"
      :hide-default-footer="true"
    >
      <template slot="items" slot-scope="props">
        <td>{{ props.item.constraintSchema }}</td>
        <td>{{ props.item.constraintName }}</td>
      </template>
    </v-data-table>
  </v-container>
</template>

<script>
  export default {
    name: 'TableUniqueConstraints',
    props: {
      uniqueConstraints: {
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
          text: 'Schema',
          sortable: true,
          value: 'constraintSchema'
        },
        {
          text: 'Name',
          sortable: true,
          value: 'constraintName'
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
