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

        <!-- <template slot="items" slot-scope="props">
          <tr>
            <td>
              <v-checkbox 
              :input-value="functionCheckValue(props.item)" 
              @change="functionCheckChanged(props.item)"
              ></v-checkbox>
            </td>
            <td @click="props.expanded = !props.expanded">
              <v-btn icon @click.stop="props.expanded = !props.expanded">
                <v-icon>{{ props.expanded ? 'expand_less' : 'expand_more' }}</v-icon>
              </v-btn>
            </td>
            <td @click="props.expanded = !props.expanded">{{ props.item.id }}</td>
            <td @click="props.expanded = !props.expanded">
              <policy-assignment-dialog 
                :currentPolicyDefinition="props.item.policyDefinition" 
                :functions="[props.item]">
              </policy-assignment-dialog>
            </td>
          </tr>
        </template>

        <template slot="expand" slot-scope="props">
          <policy-definition
            :policyId="props.item.policyDefinition.id"
            :aFunction="props.item"
          ></policy-definition>
        </template> -->
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
      // functionCheckValue (item) {
      //   return (this.selected.find(i => i.id === item.id)) !== undefined
      // },
      // functionCheckChanged (item) {
      //   const existing = this.selected.find(i => i.id === item.id)
      //   if (existing) {
      //     this.selected = this.selected.filter(i => i.id !== item.id)
      //   } else {
      //     this.selected = this.selected.concat([item])
      //   }
      // },
      // selectAllChanged (value) {
      //   if (this.selectAllValue) {
      //     this.selected = []
      //   } else {
      //     this.selected = [...this.schema.schemaFunctions]
      //   }
      // }
    },
    watch: {
    },
    computed: {
      functionsToShow () {
        return this.schema.schemaFunctions.map(
          aFunction => {
            const policyDefinitionId = this.$store.state.functionPolicyAssignments[aFunction.id]
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