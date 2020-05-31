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
    </div>
</template>

<script>
  import PolicyDefinition from '@/components/TableSecurity/Definition/TablePolicyDefinition'
  import PolicyAssignmentDialog from '@/components/TableSecurity/Assignment/TablePolicyAssignmentDialog'
  // import TablePolicyEvaluatorSummary from '@/components/TableSecurity/Evaluation/TablePolicyEvaluatorSummary'
  import TablePolicyCustomizeDialog from '@/components/TableSecurity/Dialogs/TablePolicyCustomizeDialog.vue'

  export default {
    name: 'PolicyAssignment',
    components: {
      PolicyDefinition,
      PolicyAssignmentDialog,
      // TablePolicyEvaluatorSummary,
      TablePolicyCustomizeDialog
    },
    props: {
      policyDefinitionId: {
        type: Number,
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
        const tableIds = Object.keys(this.$store.state.tablePolicyAssignments)
        .filter(tableId => {
          return this.$store.state.tablePolicyAssignments[tableId].policyDefinitionId === this.policyDefinitionId
        })

        return this.managedSchemata.reduce(
          (all, s) => {
            const tablesToAdd = s.schemaTables.filter(t => tableIds.indexOf(t.id) !== -1)
            return [
              ...all,
              ...tablesToAdd
            ]
          }, []
        )
        .map(t =>{
          return {
            ...t
            ,policyDefinition: this.policyDefinition
            ,policyDefinitionId: this.policyDefinition.id
          }
        })
        
        // this.schema.schemaTables.filter(t => t.tableType === 'BASE TABLE').map(
        //   table => {
        //     const policyDefinitionId = this.$store.state.tablePolicyAssignments[table.id].policyDefinitionId
        //     const policyDefinition = this.policies.find(p => p.id === policyDefinitionId) || this.defaultPolicy

        //     return {
        //       ...table
        //       ,policyDefinition: policyDefinition
        //       ,policyDefinitionId: policyDefinition.id
        //     }
        //   }
        // )
      },
      policyDefinition () {
        return this.policies.find(p => p.id === this.policyDefinitionId) || this.defaultPolicy
      },
      managedSchemata () {
        return this.$store.state.managedSchemata
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
