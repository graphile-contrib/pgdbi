<template>
  <v-container fluid>
    <v-data-table
      :headers="headers"
      :items="tableDetail"
      class="elevation-1 text-no-wrap"
      hide-default-footer
      calculate-widths
      dense
      :items-per-page="100"
    >
    </v-data-table>
  </v-container>
</template>

<script>
  export default {
    name: 'ViewColumns',
    props: {
      viewInfo: {
        type: Object,
        required: true
      }
    },
    components: {
    },
    methods: {
    },
    computed: {
      tableDetail () {
        const retval = (this.viewInfo.tableColumns || [])
        return retval
      },
    },
    data: () => ({
      headers: [
        {
          text: 'Ordinal',
          sortable: true,
          value: 'ordinalPosition'
        },
        {
          text: 'Column Name',
          sortable: true,
          value: 'columnName'
        },
        { 
          text: 'Data Type', 
          sortable: true,
          value: 'dataType'
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
