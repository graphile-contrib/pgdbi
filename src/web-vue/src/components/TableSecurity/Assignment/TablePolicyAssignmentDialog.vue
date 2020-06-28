
<template>
    <div>
      <v-dialog v-model="dialog" persistent width="800">
        <template v-slot:activator="{ on }">
          <v-btn 
            small
            dark v-on="on"
            class="text-none"
            :disabled="disabled"
          >
            {{ displayValue }}
          </v-btn>
        </template>
        <v-card>
          <v-card-title class="headline">Assign Policy</v-card-title>
          <v-combobox
            :items="allPolicyDefinitions"
            item-text="name"
            item-value="id"
            v-model="currentSelection"
          ></v-combobox>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn @click="dialog=false">Cancel</v-btn>
            <v-btn @click="updateTablePolicyDefinition" :disabled="updateDisabled">Update</v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
</template>

<script>
  export default {
    name: 'PolicyAssignmentDialog',
    props: {
      currentPolicyDefinition: {
        type: Object,
        required: true
      },
      tables: {
        type: Array,
        required: true
      },
      bulkAssign: {
        type: Boolean,
        default: false
      },
      disabled: {
        type: Boolean,
        default: false
      }
    },
    mounted () {
      this.currentSelection = this.currentPolicyDefinition
    },
    data () {
      return {
        dialog: false,
        currentSelection: null
      }
    },
    computed: {
      displayValue () {
        if (this.bulkAssign) {
          return 'Bulk Assign'
        } else {
          return 'Assign New Profile'
          return this.currentPolicyDefinition ? this.currentPolicyDefinition.name : 'n/a'
        }
      },
      allPolicyDefinitions () {
        return this.$store.state.policies.filter(p => !p.customIdentifier)
      },
      updateDisabled () {
        if (this.bulkAssign) {
          return false
        } else {
          return this.currentPolicyDefinition && this.currentSelection ? this.currentPolicyDefinition.id === this.currentSelection.id : true
        }
      }
    },
    watch: {
    },
    methods: {
      updateTablePolicyDefinition() {
        this.dialog = false
        const tableIds = this.tables.reduce(
          (tableIds, table) => {
            return tableIds.concat([table.id])
          }, []
        )

        this.$store.commit('assignTablePolicy', {
          tableIds: tableIds,
          policyDefinitionId: this.currentSelection.id
        })

        this.$emit('policyAssigned', this.tables)
      }
    }
  }
</script>

<style>
.norm-text {
  text-transform: none !important;
}
</style>