<template>
  <v-card color="black">
    <v-container background-color="black">
      <v-data-table
        :headers="headers"
        :items="referentialConstraints"
        :hide-default-footer="true"
        stripe
      >
        <template slot="items" slot-scope="props">
          <tr>
            <td v-for="action in actionColumns(props.item)" :key="action">
              <v-checkbox 
              :input-value="props.item.actions[action]" 
              @change="actionChanged(action, props.item)"
              ></v-checkbox>
            </td>
            <td>{{ props.item.columnName }}</td>
            <td>{{ props.item.constraintName }}</td>
            <td>{{ props.item.indexName }}</td>
            <td>{{ props.item.expectedIndexName }}</td>
            <td>{{ props.item.columnIndexStatus }}</td>
          </tr>
        </template>
      </v-data-table>
    </v-container>
  </v-card>
</template>

<script>
  export default {
    name: 'FkIndexEvaluatorSegment',
    props: {
      referentialConstraints: {
        type: Array,
        required: true
      },
      actions: {
        type: Array,
        required: true
      }
    },
    components: {
      // PolicyDefinition,
      // PolicyAssignmentDialog
    },
    methods: {
      actionColumns (row) {
        return Object.keys(row.actions)
      },
      actionChanged (action, row) {
        console.log('actionChanged', action, row)
      },
    },
    watch: {
    },
    computed: {
      headers() {
        return [
          ...this.actions.map(
            action => {
              return {
                text: action,
                sortable: false
              }
            }
          ),
          {
            text: 'Column  Name',
            sortable: false
          },
          {
            text: 'FK Name',
            sortable: false
          },
          {
            text: 'Index',
            sortable: false
          },
          {
            text: 'Expected',
            sortable: false
          },
          {
            text: 'status',
            sortable: false
          },
        ]
      }
    },
    data: (actionColumns) => ({
    })
  }
</script>