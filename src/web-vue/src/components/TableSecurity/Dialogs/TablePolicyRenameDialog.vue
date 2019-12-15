
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
          <v-card-title class="headline">Rename Policy</v-card-title>
          
          <v-text-field v-model="policyName"></v-text-field>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn @click="dialog=false">Cancel</v-btn>
            <v-btn @click="renameTablePolicyDefinition" :disabled="renameDisabled">Rename</v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
</template>

<script>
  export default {
    name: 'TablePolicyRenameDialog',
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
        dialog: false,
        policyName: ''
      }
    },
    computed: {
      displayValue () {
        return 'Rename'
      },
      allPolicyDefinitions () {
        return this.$store.state.policies.filter(p => !p.customIdentifier)
      },
      renameDisabled () {
        return false
      }
    },
    watch: {
    },
    methods: {
      renameTablePolicyDefinition() {
        this.dialog = false

        this.$store.commit('renameTablePolicy', {
          policyDefinitionId: this.policyDefinition.id,
          name: this.policyName
        })
      }
    },
    mounted () {
      this.policyName = this.policyDefinition.name
    }
  }
</script>

<style>
.norm-text {
  text-transform: none !important;
}
</style>