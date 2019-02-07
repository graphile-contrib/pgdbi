<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="mappedTriggers"
      class="elevation-1"
      :pagination.sync="pagination"
      :hide-actions="true"
      item-key="id"
    >
      <template slot="items" slot-scope="props">
        <tr @click="props.expanded = !props.expanded">        
          <td>{{ props.item.triggerName }}</td>
          <td>{{ props.item.eventManipulation }}</td>
          <td>{{ props.item.actionOrientation }}</td>
          <td>{{ props.item.actionTiming }}</td>
          <td>{{ props.item.actionStatement }}</td>
        </tr>
      </template>

      <template slot="expand" slot-scope="props">
        <v-card flat>
          <v-textarea
            readonly
            outline
            :value="props.item.functionDefinition"
            auto-grow
          >
          </v-textarea>
        </v-card>
      </template>

    </v-data-table>
  </v-container>
</template>

<script>
  export default {
    name: 'TableTriggers',
    props: {
      triggers: {
        type: Array,
        required: true
      }
    },
    computed: {
      mappedTriggers () {
        return this.triggers.map(
          trigger => {
            return {
              ...trigger,
              expanded: false,
              functionDefinition: trigger.triggerFunction ? trigger.triggerFunction.definition : 'N/A'
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
          align: 'left',
          sortable: true,
          value: 'triggerName'
        },
        {
          text: 'Trigger On',
          align: 'left',
          sortable: true,
          value: 'eventManipulation'
        },
        {
          text: 'Action Orientation',
          align: 'left',
          sortable: true,
          value: 'actionOrientation'
        },
        {
          text: 'Timing',
          align: 'left',
          sortable: true,
          value: 'actionTiming'
        },
        {
          text: 'Statement',
          align: 'left',
          sortable: true,
          value: 'actionStatement'
        },
      ],
      pagination: {
        sortBy: 'triggerName',
        rowsPerPage: -1
      },
    })
  }
</script>

<style>

</style>
