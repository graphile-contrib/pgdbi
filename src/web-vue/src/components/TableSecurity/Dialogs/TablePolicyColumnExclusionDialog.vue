
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
          <v-card-title class="headline">Exclude Column</v-card-title>
          <v-text-field v-model="columnName"></v-text-field>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn @click="dialog=false">Cancel</v-btn>
            <v-btn @click="addColumnExclusion">Exclude</v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
</template>

<script>
  export default {
    name: 'TablePolicyColumnExclusionDialog',
    props: {
      policyDefinition: {
        type: Object,
        required: true
      },
      table: {
        type: Object,
        required: false
      },
      disabled: {
        type: Boolean,
        default: false
      }      
    },
    data () {
      return {
        dialog: false,
        columnName: ''
      }
    },
    computed: {
      displayValue () {
          return 'New Column Exclusion(s)'
      }
    },
    watch: {
    },
    methods: {
      addColumnExclusion() {
        this.dialog = false
        const columnExclusions = this.policyDefinition.columnExclusions
          .filter(ce => ce.columnName !== this.columnName)
          .concat(
            [
              {
                columnName: this.columnName
                ,excludeForInsert: true
                ,excludeForUpdate: true
              }
            ]
          )

        try {
          this.$store.commit('savePolicy', {
            policy: {
              ...this.policyDefinition,
              columnExclusions: columnExclusions
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