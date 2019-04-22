<template>
  <v-container>
    <table-policy-column-exclusion-dialog
      :policyDefinition="policyDefinition"
      :table="table"
    >
    </table-policy-column-exclusion-dialog>
    <hr>
    <v-data-table
      :headers="headers"
      :items="policyDefinition.columnExclusions"
      hide-actions
      class="text-sm-left"
    >
      <template slot="items" slot-scope="props">
        <td>{{ props.item.columnName }}</td>
        <td>
          <v-checkbox 
            :input-value="props.item.excludeForInsert"
            @click="toggleInsert(props.item)"
          ></v-checkbox>
        </td>
        <td>
          <v-checkbox 
            :input-value="props.item.excludeForUpdate"
            @click="toggleUpdate(props.item)"
          ></v-checkbox>
        </td>
        <td><v-btn @click="removeColumnExclusion(props.item)">Remove</v-btn></td>
      </template>
    </v-data-table>
  </v-container>
</template>

<script>
  import { mapGetters } from 'vuex'
  import TablePolicyColumnExclusionDialog from '@/components/TableSecurity/Dialogs/TablePolicyColumnExclusionDialog.vue'

  export default {
    name: 'PolicyDefinitionColumnExclusions',
    components: {
      TablePolicyColumnExclusionDialog
    },
    props: {
      policyDefinition: {
        type: Object,
        required: true
      },
      table: {
        type: Object,
        required: false
      },
      disabled: {
        type: Boolean,
        default: false
      }
    },
    data () {
      return {
        toggleComplete: false,
        headers: [
          {
            text: 'Column Name',
            sortable: false
          },
          {
            text: 'Exclude for Insert',
            sortable: false
          },
          {
            text: 'Exclude for Update',
            sortable: false
          },
        ]
      }
    },
    watch: {
    },
    methods: {
      toggleInsert(columnExclusion) {
        if (this.toggleComplete) {
          this.toggleComplete = false
          return
        } else {
          const updatedColumnExclusions = this.policyDefinition.columnExclusions
            .filter(ce => ce.columnName !== columnExclusion.columnName)
            .concat([
              {
                ...columnExclusion,
                excludeForInsert: !columnExclusion.excludeForInsert
              }
            ])

          const updatedPolicy = {
            ...this.policyDefinition,
            columnExclusions: updatedColumnExclusions

          }

          this.$store.commit('savePolicy', { policy: updatedPolicy })

          this.toggleComplete = true
        }
      },
      toggleUpdate(columnExclusion) {
        if (this.toggleComplete) {
          this.toggleComplete = false
          return
        } else {
          const updatedColumnExclusions = this.policyDefinition.columnExclusions
            .filter(ce => ce.columnName !== columnExclusion.columnName)
            .concat([
              {
                ...columnExclusion,
                excludeForUpdate: !columnExclusion.excludeForUpdate
              }
            ])

          const updatedPolicy = {
            ...this.policyDefinition,
            columnExclusions: updatedColumnExclusions

          }

          this.$store.commit('savePolicy', { policy: updatedPolicy })

          this.toggleComplete = true
        }
      },
      removeColumnExclusion (columnExclusion) {
        const columnExclusions = this.policyDefinition.columnExclusions.filter(ce => ce.columnName !== columnExclusion.columnName)

        try {
          this.$store.commit('savePolicy', {
            policy: {
              ...this.policyDefinition,
              columnExclusions: columnExclusions
            }
          })
        }
        catch (e) {
          alert(e.toString())
          console.error(e)
        }
      }
    },
    computed: {
    }
  }
</script>