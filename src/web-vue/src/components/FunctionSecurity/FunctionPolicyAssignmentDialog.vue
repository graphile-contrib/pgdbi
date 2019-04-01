
<template>
    <div>
      <v-dialog v-model="dialog" persistent width="800">
        <template v-slot:activator="{ on }">
          <v-btn 
            dark v-on="on"
            class="text-none"
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
            <!-- <v-btn :hidden="disabled" @click="updateRlsPolicy(roleName, action, rlsPolicy.id, currentUsing, currentWithCheck, currentPassStrategy, currentName); dialog=false">Update</v-btn>
            <v-btn :hidden="disabled" @click="disableRlsPolicy(roleName, action, rlsPolicy.id); dialog=false">Disable</v-btn> -->
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
    name: 'FunctionAssignmentDialog',
    props: {
      currentPolicyDefinition: {
        type: Object,
        required: true
      },
      theFunction: {
        type: Object,
        required: true
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
        return this.currentPolicyDefinition ? this.currentPolicyDefinition.name : 'n/a'
      },
      allPolicyDefinitions () {
        return this.$store.state.functionPolicies
      },
      updateDisabled () {
        return this.currentPolicyDefinition && this.currentSelection ? this.currentPolicyDefinition.id === this.currentSelection.id : true
      }
    },
    watch: {
    },
    methods: {
      updateTablePolicyDefinition() {
        // console.log('save', JSON.stringify(this.theFunction,0,2), JSON.stringify(this.currentSelection,0,2))
        console.log('save', this.theFunction.id, this.currentSelection.name)
        this.dialog = false
        this.$store.commit('assignFunctionPolicy', {
          functionId: this.theFunction.id,
          policyDefinitionId: this.currentSelection.id
        })
      }
    }
  }
</script>

<style>
.norm-text {
  text-transform: none !important;
}
</style>