<template>
    <div>
      <v-toolbar>
        <policy-assignment-dialog 
          :currentPolicyDefinition="defaultPolicy" 
          :functions="selected"
          :bulkAssign="true"
          :disabled="selected.length === 0"
        ></policy-assignment-dialog>
      </v-toolbar>
      <v-data-table
        v-model="selected"
        :headers="headers"
        :items="functionsToShow"
        item-key="id"
        dense
        disable-pagination
        disable-sort
        hide-default-footer
        show-select
        show-expand
      >
          <template v-slot:item.name="{ item }">
            {{ item.functionName }}
          </template>

          <template v-slot:item.assignedPolicy="{ item }">
            <policy-assignment-dialog 
              :currentPolicyDefinition="item.policyDefinition" 
              :functions="[item]"
              @policyAssigned="expandItems"
            ></policy-assignment-dialog>
          </template>

        <template slot="expanded-item" slot-scope="props">
          <td :colspan="headers.length + 2">
            <policy-definition
              :policyId="props.item.policyDefinition.id"
              :aFunction="props.item"
            ></policy-definition>
          </td>
        </template>

      </v-data-table>
    </div>
</template>

<script>
  import PolicyDefinition from '@/components/FunctionSecurity/Definition/FunctionPolicyDefinition'
  import PolicyAssignmentDialog from '@/components/FunctionSecurity/Assignment/FunctionPolicyAssignmentDialog'

  export default {
    name: 'FunctionAssignment',
    components: {
      PolicyDefinition,
      PolicyAssignmentDialog
    },
    props: {
      schema: {
        type: Object,
        required: true
      }
    },
    methods: {
      expandItems (items) {
        this.expanded = items
      }
    },
    watch: {
    },
    computed: {
      functionsToShow () {
        return this.schema.schemaFunctions.map(
          aFunction => {
            const policyDefinitionId = this.$store.state.functionPolicyAssignments[aFunction.id].policyDefinitionId
            const policyDefinition = this.$store.state.functionPolicies.find(p => p.id === policyDefinitionId)

            return {
              ...aFunction
              ,policyDefinition: policyDefinition
              ,policyDefinitionId: policyDefinitionId
            }
          }
        )
      },
      selectAllValue () {
        return this.schema.schemaFunctions.length === this.selected.length
      },
      defaultPolicy () {
        return this.$store.state.defaultFunctionPolicy
      },
    },
    data: () => ({
      selected: [],
      headers: [
        {
          text: '',
          sortable: false,
        },
        {
          text: '',
          sortable: false,
        },
        {
          text: 'Function Name',
          sortable: false,
          value: 'functionName'
        },
        {
          text: 'Policy Name',
          sortable: false,
          value: 'assignedPolicy'
        }
      ]
    })
  }
</script>