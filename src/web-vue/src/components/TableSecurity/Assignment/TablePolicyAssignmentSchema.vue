<template>
    <div>
      <v-toolbar>
        <v-checkbox 
          @change="selectAllChanged()" 
          :input-value="selectAllValue"
        ></v-checkbox>
        <v-spacer></v-spacer>
        <policy-assignment-dialog 
          :currentPolicyDefinition="defaultPolicy" 
          :tables="selected"
          :bulkAssign="true"
          :disabled="selected.length < 1"
        ></policy-assignment-dialog>
      </v-toolbar>
      <v-data-table
        :headers="headers"
        :items="tablesToShow"
        :hide-actions="true"
      >
        <!-- <template slot="headers" slot-scope="props">
          <tr>
            <th>
            </th>
            <th>
              Table Name
            </th>
            <th>
              Assigned Policy
            </th>
            <th>
              Current grant status compared to assigned policy - <span style="color: red;"><b>UNDER CONSTRUCTION</b></span>
            </th>
          </tr>
        </template> -->
        
        <template slot="items" slot-scope="props">
          <tr>
            <td>
              <v-checkbox 
              :input-value="tableCheckValue(props.item)" 
              @change="tableCheckChanged(props.item)"
              ></v-checkbox>
            </td>
            <td @click="props.expanded = !props.expanded">
              <v-btn icon @click.stop="props.expanded = !props.expanded">
                <v-icon>{{ props.expanded ? 'expand_less' : 'expand_more' }}</v-icon>
              </v-btn>
              {{ props.item.name }}
            </td>
            <!-- <td>{{ props.item.policyDefinition.name }}</td> -->
            <td @mousedown="props.expanded = !props.expanded">      
              <policy-assignment-dialog 
                :currentPolicyDefinition="props.item.policyDefinition" 
                :tables="[props.item]"
              ></policy-assignment-dialog>
              <table-policy-customize-dialog
                v-if="showCustomizeButton(props.item)"
                :currentPolicyDefinition="props.item.policyDefinition"
                :tables="[props.item]"
              ></table-policy-customize-dialog>
            </td>
            <td colspan="4" @click="props.expanded = !props.expanded">      
              <table-policy-evaluator-summary
                :policyDefinition="props.item.policyDefinition" 
                :table="props.item"              
              >
              </table-policy-evaluator-summary>
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
      <!-- <mugen-scroll :handler="fetchData" :should-handle="!loa    ding">
        loading...
      </mugen-scroll> -->
    </div>
</template>

<script>
  import MugenScroll from 'vue-mugen-scroll'
  import PolicyDefinition from '@/components/TableSecurity/Definition/TablePolicyDefinition'
  import PolicyAssignmentDialog from '@/components/TableSecurity/Assignment/TablePolicyAssignmentDialog'
  import TablePolicyEvaluatorSummary from '@/components/TableSecurity/Assignment/TablePolicyEvaluatorSummary'
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
    // mounted () {
    //   this.fetchData()
    // },
    methods: {
      // fetchData () {
      //   this.tablesToShow.push(this.schema.schemaTables.slice(this.tablesToShow.length, 5))
      //   console.log('table', this.tablesToShow)
      // },
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
      tablesToShow () {
        return this.schema.schemaTables//.slice(0, 10)
      },
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
      loading: false,
      // tablesToShow: [],
      selected: [],
      headers: [
        {
          text: '',
          align: 'left',
          sortable: false,
        },
        {
          text: 'Table Name',
          align: 'left',
          sortable: false,
        },
        {
          text: 'Assigned Policy',
          align: 'left',
          sortable: false,
        },
        {
          text: 'Current grant status compared to assigned policy - UNDER CONSTRUCTION',
          align: 'center',
          class: 'blah',
          sortable: false,
          colspan: 4
        }
      ]
    })
  }
</script>

<style>
.blah {
  color: red
}
</style>
