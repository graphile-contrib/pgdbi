<template>
  <v-card color="black">
    <v-container background-color="black">
      <v-data-table
        :headers="headers"
        :items="referentialConstraints"
        :hide-actions="true"
      >
        <template slot="items" slot-scope="props">
          <tr>
            <td>{{ props.item.fieldName }}</td>
            <td>{{ props.item.constraintName }}</td>
            <td>{{ props.item.indexValue }}</td>
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
    },
    watch: {
    },
    computed: {
      referentialConstraints () {
        console.log('blah', this.table)
        const retval = this.table.referentialConstraints.map(
          rc => {
            const columnName = rc.referencingColumnUsage[0].columnName
            const indices = this.table.indices.filter(i => i.columnName === columnName)
            let indexValue
            switch (indices.length) {
              case 0:
                indexValue = 'No index for this foreign key'
                break
              case 0:
                indexValue = indices[0].indexName
                break
              default:
                indexValue = 'Multiple indices for this foreign key'
                break
            }
            

            return {
              fieldName: columnName,
              constraintName: rc.constraintName,
              indexValue: indexValue
            }
          }
        )
        console.log('retval', retval)
        return retval
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
        }
      ]
    })
  }
</script>