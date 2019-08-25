<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="items"
      class="elevation-1"
      :hide-default-footer="true"
    >
    </v-data-table>
  </v-container>
</template>

<script>
  export default {
    name: 'TableFKIndices',
    props: {
      fkIndices: {
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
    computed: {
      items () {
        return this.fkIndices
          .map(
            i => {
              return {
                ...i
              }
            }
          )
      }
    },
    data: () => ({
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
