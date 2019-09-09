<template>
  <v-container>
    <v-card
      class="ma-3 pa-3 blue darken-4"
      dense
    >            
      <h2>Check Constraints</h2>
      <v-data-table
        :headers="headers"
        :items="mappedConstraints"
        class="elevation-1"
        :hide-default-footer="true"
      >
      </v-data-table>
    </v-card>
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
          text: 'Name',
          sortable: true,
          value: 'constraintName'
        },
        {
          text: 'Check Clause',
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
