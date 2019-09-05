<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="mappedConstraints"
      class="elevation-1"
      :hide-default-footer="true"
      item-key="constraintName"
    >
      <template slot="items" slot-scope="props">
        <tr @click="props.expanded = !props.expanded">        
          <td>{{ props.item.constraintName }}<hr>{{ props.item.source }}</td>
          <td>{{ props.item.uniqueConstraintName }}<hr>{{ props.item.target }}</td>
          <td>{{ props.item.matchOption }}</td>
          <td>{{ props.item.updateRule }}</td>
          <td>{{ props.item.deleteRule }}</td>
        </tr>
      </template>
      <template slot="expand" slot-scope="props">
        <v-card flat>
          <h2>Source</h2>
          <table-key-column-usage
            :keyColumnUsage="props.item.referencingColumnUsage"
          ></table-key-column-usage>
        </v-card>
        <v-card flat>
          <h2>Target</h2>
          <table-key-column-usage
            :keyColumnUsage="props.item.referencedColumnUsage"
          ></table-key-column-usage>
        </v-card>
      </template>
    </v-data-table>
  </v-container>
</template>

<script>
  import TableKeyColumnUsage from './TableKeyColumnUsage.vue'

  export default {
    name: 'TableReferentialConstraints',
    components: {
      TableKeyColumnUsage
    },
    props: {
      referentialConstraints: {
        type: Array,
        required: true
      }
    },
    computed: {
      mappedConstraints () {
        return this.referentialConstraints.map(
          constraint => {
            return {
              ...constraint,
              expanded: false,
              source: `${constraint.referencingColumnUsage[0].tableSchema}.${constraint.referencingColumnUsage[0].tableName}.${constraint.referencingColumnUsage[0].columnName}`,
              target: `${constraint.referencedColumnUsage[0].tableSchema}.${constraint.referencedColumnUsage[0].tableName}.${constraint.referencedColumnUsage[0].columnName}`
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
          text: 'Source Constraint',
          align: 'left',
          sortable: true,
          value: 'constraintName'
        },
        {
          text: 'Target Constraint',
          align: 'left',
          sortable: true,
          value: 'uniqueConstraintName'
        },
        {
          text: 'On Match',
          align: 'left',
          sortable: true,
          value: 'matchOption'
        },
        {
          text: 'On Update',
          align: 'left',
          sortable: true,
          value: 'updateRule'
        },
        {
          text: 'On Delete',
          align: 'left',
          sortable: true,
          value: 'deleteRule'
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
