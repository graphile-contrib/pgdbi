<template>
    <div>
      <v-toolbar>
        <v-checkbox 
          @change="selectAllChanged()" 
          :input-value="selectAllValue"
        ></v-checkbox>
        <v-spacer></v-spacer>
        <!-- <v-btn :disabled="selected.length === 0" @click="bulkAssign">Bulk Assign</v-btn> -->
        <policy-assignment-dialog 
          :currentPolicyDefinition="defaultPolicy" 
          :tables="selected"
          :bulkAssign="true"
          :disabled="selected.length < 2"
        ></policy-assignment-dialog>
      </v-toolbar>
      <v-data-table
        :headers="headers"
        :items="schema.schemaTables"
        :hide-actions="true"
      >
        <template slot="items" slot-scope="props">
          <!-- <tr @click="props.expanded = !props.expanded"> -->
          <tr>
            <td>
              <v-checkbox 
              :input-value="tableCheckValue(props.item)" 
              @change="tableCheckChanged(props.item)"
              ></v-checkbox>
            </td>
            <td>      
              <v-btn icon @click.stop="props.expanded = !props.expanded">
                <v-icon>{{ props.expanded ? 'expand_less' : 'expand_more' }}</v-icon>
              </v-btn>
            </td>
            <td>{{ props.item.name }}</td>
            <!-- <td>{{ props.item.policyDefinition.name }}</td> -->
            <td>
              <policy-assignment-dialog 
                :currentPolicyDefinition="props.item.policyDefinition" 
                :tables="[props.item]"
              ></policy-assignment-dialog>
            </td>
          </tr>
        </template>

        <template slot="expand" slot-scope="props">
          <policy-definition
            :policyId="props.item.policyDefinition.id"
            :table="props.item"
          ></policy-definition>
        </template>
      </v-data-table>
    </div>
</template>

<script>
  import PolicyDefinition from '@/components/TableSecurity/TablePolicyDefinition'
  import PolicyAssignmentDialog from '@/components/TableSecurity/TablePolicyAssignmentDialog'

  export default {
    name: 'PolicyAssignment',
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
      tableCheckValue (item) {
        return (this.selected.find(i => i.id === item.id)) !== undefined
      },
      tableCheckChanged (item) {
        const existing = this.selected.find(i => i.id === item.id)
        if (existing) {
          this.selected = this.selected.filter(i => i.id !== item.id)
        } else {
          this.selected = this.selected.concat([item])
        }
      },
      selectAllChanged (value) {
        if (this.selectAllValue) {
          this.selected = []
        } else {
          this.selected = [...this.schema.schemaTables]
        }
      }
    },
    watch: {
    },
    computed: {
      selectAllValue () {
        return this.schema.schemaTables.length === this.selected.length
      },
      defaultPolicy () {
        return this.$store.state.defaultPolicy
      },
      policies () {
        return this.$store.state.policies
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
          text: 'Table Name',
          sortable: false,
        },
        {
          text: 'Policy Name',
          sortable: false,
        },
        {
          text: '',
          sortable: false,
        },
      ]
    })
  }
</script>