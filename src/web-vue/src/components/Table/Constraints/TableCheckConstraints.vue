<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="mappedConstraints"
      class="elevation-1"
      :hide-default-footer="true"
    >
      <template slot="items" slot-scope="props">
        <td>{{ props.item.constraintSchema }}</td>
        <td>{{ props.item.tableName }}</td>
        <td>{{ props.item.constraintName }}</td>
        <td>{{ props.item.checkClause }}</td>
      </template>
    </v-data-table>
  </v-container>
</template>

<script>
  export default {
    name: 'TableCheckConstraints',
    props: {
      checkConstraints: {
        type: Array,
        required: true
      }
    },
    computed: {
      mappedConstraints () {
        return this.checkConstraints.map(
          constraint => {
            return {
              ...constraint,
              expanded: false,
              tableName: constraint.tableConstraints[0].tableName
            }
          }
        )
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
          align: 'left',
          sortable: true,
          value: 'constraintSchema'
        },
        {
          text: 'Table',
          align: 'left',
          sortable: true,
          value: 'tableName'
        },
        {
          text: 'Name',
          align: 'left',
          sortable: true,
          value: 'constraintName'
        },
        {
          text: 'Check Clause',
          align: 'left',
          sortable: true,
          value: 'checkClause'
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
