<template>
  <v-card color="black">
    <v-container background-color="black">
      <v-data-table
        :headers="headers"
        :items="referentialConstraints"
        :hide-actions="true"
        stripe
      >
        <template slot="items" slot-scope="props">
          <tr>
            <td>{{ props.item.columnName }}</td>
            <td>{{ props.item.constraintName }}</td>
            <td>{{ props.item.columnIndexStatus }}</td>
            <td><v-icon :color="props.item.columnIndexStatusColor">fiber_manual_record</v-icon></td>
            <td>
              <v-checkbox 
              :input-value="createIndexSelected(props.item)" 
              @change="createIndexChanged(props.item)"
              ></v-checkbox>
            </td>
            <td>
              <v-checkbox 
              :input-value="renameIndexSelected(props.item)" 
              @change="renameIndexChanged(props.item)"
              ></v-checkbox>
            </td>
            <td>
              <v-checkbox 
              :input-value="dropIndexSelected(props.item)" 
              @change="dropIndexChanged(props.item)"
              ></v-checkbox>
            </td>
            <td>
              <v-checkbox 
              :input-value="ackIndexSelected(props.item)" 
              @change="ackIndexChanged(props.item)"
              ></v-checkbox>
            </td>
          </tr>
        </template>
      </v-data-table>
    </v-container>
  </v-card>
</template>

<script>
  export default {
    name: 'FkIndexEvaluator',
    props: {
      table: {
        type: Object,
        required: true
      }
    },
    components: {
      // PolicyDefinition,
      // PolicyAssignmentDialog
    },
    methods: {
      createIndexSelected () {
        return true
      },
      createIndexChanged (item) {
        console.log('cic', item)
      },
      renameIndexSelected () {
        return true
      },
      renameIndexChanged (item) {
        console.log('cic', item)
      },
      dropIndexSelected () {
        return true
      },
      dropIndexChanged (item) {
        console.log('cic', item)
      },
      ackIndexSelected () {
        return true
      },
      ackIndexChanged (item) {
        console.log('cic', item)
      },
    },
    watch: {
    },
    computed: {
      referentialConstraints () {
        return this.table.referentialConstraints
      }
    },
    data: () => ({
      headers: [
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
          text: 'Status',
          sortable: false
        },
        {
          text: 'Create',
          sortable: false
        },
        {
          text: 'Rename',
          sortable: false
        },
        {
          text: 'Drop',
          sortable: false
        },
        {
          text: 'Ack',
          sortable: false
        }
      ]
    })
  }
</script>