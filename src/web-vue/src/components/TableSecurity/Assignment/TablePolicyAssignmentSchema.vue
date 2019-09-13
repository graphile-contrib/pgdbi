<template>
    <div>
      <v-toolbar>
        <policy-assignment-dialog 
          :currentPolicyDefinition="defaultPolicy" 
          :tables="selected"
          :bulkAssign="true"
          :disabled="selected.length < 1"
        ></policy-assignment-dialog>
      </v-toolbar>
      <v-data-table
        v-model="selected"
        :headers="headers"
        :items="tablesToShow"
        item-key="id"
        dense
        disable-pagination
        disable-sort
        hide-default-footer
        show-select
        show-expand
        :expanded.sync="expanded"
      >
          <template v-slot:item.name="{ item }">
            {{ item.tableName }}
          </template>

          <template v-slot:item.assignedPolicy="{ item }">
            <policy-assignment-dialog 
              :currentPolicyDefinition="item.policyDefinition" 
              :tables="[item]"
              @policyAssigned="expandItems"
            ></policy-assignment-dialog>
            <table-policy-customize-dialog
              v-if="showCustomizeButton(item)"
              :currentPolicyDefinition="item.policyDefinition"
              :tables="[item]"
              @policyAssigned="expandItems"
            ></table-policy-customize-dialog>
          </template>

        <template slot="expanded-item" slot-scope="props">
          <td :colspan="headers.length + 2">
            <policy-definition
              :key="props.item.id"
              :policyId="props.item.policyDefinition.id"
              :table="props.item"
            ></policy-definition>
          </td>
        </template>
      </v-data-table>

      <!-- <mugen-scroll :handler="fetchData" :should-handle="!loa    ding">
        loading...
      </mugen-scroll> -->
    </div>
</template>

<script>
  import MugenScroll from 'vue-mugen-scroll'
  import PolicyDefinition from '@/components/TableSecurity/Definition/TablePolicyDefinition'
  import PolicyAssignmentDialog from '@/components/TableSecurity/Assignment/TablePolicyAssignmentDialog'
  import TablePolicyEvaluatorSummary from '@/components/TableSecurity/Evaluation/TablePolicyEvaluatorSummary'
  import TablePolicyCustomizeDialog from '@/components/TableSecurity/Dialogs/TablePolicyCustomizeDialog.vue'

  export default {
    name: 'PolicyAssignment',
    components: {
      PolicyDefinition,
      PolicyAssignmentDialog,
      TablePolicyEvaluatorSummary,
      TablePolicyCustomizeDialog,
      MugenScroll
    },
    props: {
      schema: {
        type: Object,
        required: true
      }
    },
    methods: {
      showCustomizeButton (table) {
        if (table) {
          if (table.policyDefinition && table.policyDefinition.customIdentifier) {
            return false
          } else {
            return true
          }
        } else {
          return false
        }
      },
      expandItems (items) {
        this.expanded = items
      }
    },
    watch: {
      // expanded () {
      //   console.log(this.expanded)
      // }
    },
    computed: {
      tablesToShow () {
        return this.schema.schemaTables.map(
          table => {
            const policyDefinitionId = this.$store.state.tablePolicyAssignments[table.id].policyDefinitionId
            const policyDefinition = this.policies.find(p => p.id === policyDefinitionId)

            return {
              ...table
              ,policyDefinition: policyDefinition
              ,policyDefinitionId: policyDefinitionId
            }
          }
        )
      },
      defaultPolicy () {
        return this.$store.state.defaultPolicy
      },
      policies () {
        return this.$store.state.policies
      },
    },
    data: () => ({
      loading: false,
      selected: [],
      expanded: [],
      headers: [
        {
          text: '',
          sortable: false,
        },
        {
          text: 'Table Name',
          sortable: false,
          value: 'name'
        },
        {
          text: 'Assigned Policy',
          sortable: false,
          value: 'assignedPolicy'
        },
      ]
    })
  }
</script>

<style>
.blah {
  color: red
}
</style>
