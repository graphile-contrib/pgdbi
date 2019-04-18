
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
          <v-card-title class="headline">Make Custom Policy Available Globally</v-card-title>
          <v-text-field v-model="customName"></v-text-field>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn @click="dialog=false">Cancel</v-btn>
            <v-btn @click="makeGlobal">Make Global</v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
</template>

<script>
  export default {
    name: 'TablePolicyMakeGlobalDialog',
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
    data () {
      return {
        dialog: false,
        customName: 'New Table Policy'
      }
    },
    computed: {
      displayValue () {
          return 'Make Global'
      }
    },
    watch: {
    },
    methods: {
      makeGlobal() {
        this.dialog = false

        try {
          this.$store.commit('makeGlobalTablePolicy', {
            policyDefinitionId: this.policyDefinition.id,
            newFields: {
              name: this.customName
            }
          })
        }
        catch (e) {
          alert(e.toString())
          console.error(e)
        }
      }
    }
  }
</script>

<style>
.norm-text {
  text-transform: none !important;
}
</style>