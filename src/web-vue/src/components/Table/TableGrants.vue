<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="grants"
      class="elevation-1"
      :hide-default-footer="true"
    >
      <template slot="items" slot-scope="props">
        <!-- <td>{{ props.item.tableSchema }}</td>
        <td>{{ props.item.tableName }}</td> -->
        <td>{{ props.item.grantee }}</td>
        <!-- <td>{{ props.item.grantor }}</td> -->
        <td>{{ props.item.privilegeType }}</td>
        <!-- <td>{{ props.item.isGrantable }}</td>
        <td>{{ props.item.withHierarchy }}</td> -->
      </template>
    </v-data-table>
  </v-container>
</template>

<script>
  export default {
    name: 'TableGrants',
    props: {
      grants: {
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
        // {
        //   text: 'Schema',
        //   align: 'left',
        //   sortable: true,
        //   value: 'tableSchema'
        // },
        // {
        //   text: 'Table',
        //   align: 'left',
        //   sortable: true,
        //   value: 'tableName'
        // },
        // {
        //   text: 'Grantee',
        //   align: 'left',
        //   sortable: true,
        //   value: 'grantee'
        // },
        {
          text: 'Grantor',
          align: 'left',
          sortable: true,
          value: 'grantor'
        },
        {
          text: 'Privilege Type',
          align: 'left',
          sortable: true,
          value: 'privilegeType'
        },
        // {
        //   text: 'Is Grantable',
        //   align: 'left',
        //   sortable: true,
        //   value: 'isGrantable'
        // },
        // {
        //   text: 'With Hierarchy',
        //   align: 'left',
        //   sortable: true,
        //   value: 'withHierarchy'
        // },
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
