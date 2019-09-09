<template>
  <v-container>
    <h4>{{actionTiming}} - {{eventManipulation}}</h4>
    <v-data-table
      :headers="headers"
      :items="mappedTriggers"
      class="elevation-1"
      :hide-default-footer="true"
      item-key="id"
      show-expand
    >
      <template slot="expanded-item" slot-scope="props">
        <td :colspan="headers.length + 1">
          <function 
            :id="props.item.functionId"
            context="trigger"
          >
          </function>
        </td>
      </template>

    </v-data-table>
  </v-container>
</template>

<script>
  import Function from '@/components/Function/Function'

export default {
    name: 'TableTriggers',
    props: {
      actionTiming: {
        type: String,
        required: true
      },
      eventManipulation: {
        type: String,
        required: true
      },
      triggers: {
        type: Array,
        required: true
      }
    },
    components: {
      Function
    },
    computed: {
      mappedTriggers () {
        return this.triggers.map(
          trigger => {
            const functionId = `${trigger.actionStatement.split(' ')[2].split('(')[0]}`
            
            return {
              ...trigger,
              functionId: functionId
            }
          }
        )
        .sort(
          (a, b) => {
            return a.actionTiming < b.actionTiming
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
          value: 'triggerName',
          width: '20%'
        },
        {
          text: 'Timing',
          sortable: true,
          value: 'actionTiming',
          width: '10%'
        },
        {
          text: 'Trigger On',
          sortable: true,
          value: 'eventManipulation',
          width: '10%'
        },
        {
          text: 'Statement',
          sortable: true,
          value: 'actionStatement',
          width: '60%'
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
