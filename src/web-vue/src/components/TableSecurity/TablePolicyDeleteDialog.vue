
<template>
    <div>
      <v-dialog v-model="dialog" persistent width="800">
        <template v-slot:activator="{ on }">
          <v-btn 
            dark v-on="on"
            class="text-none"
            :disabled="disabled"
          >
            {{ displayValue }}
          </v-btn>
        </template>
        <v-card>
          <v-card-title class="headline">Delete Policy</v-card-title>
          <h1>Are you sure you want to delete this policy?</h1>
          <h2>Any tables currently assigned this policy will revert to:</h2>
          <h2>Default Policy - NO ACCESS</h2>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn @click="dialog=false">Cancel</v-btn>
            <v-btn @click="deleteTablePolicyDefinition" :disabled="deleteDisabled">Delete</v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
</template>

<script>
  export default {
    name: 'TablePolicyDeleteDialog',
    props: {
      policyDefinition: {
        type: Object,
        required: true
      },
      disabled: {
        type: Boolean,
        default: false
      }
    },
    mounted () {
    },
    data () {
      return {
        dialog: false
      }
    },
    computed: {
      displayValue () {
        return 'Delete'
      },
      allPolicyDefinitions () {
        return this.$store.state.policies.filter(p => !p.customIdentifier)
      },
      deleteDisabled () {
        return false
      }
    },
    watch: {
    },
    methods: {
      deleteTablePolicyDefinition() {
        this.dialog = false

        this.$store.commit('deleteTablePolicy', {
          policyDefinitionId: this.policyDefinition.id
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