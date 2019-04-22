
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
      action: {
        type: String,
        required: true
      },
      roleName: {
        type: String,
        required: true
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
          return `New ${this.action} exclusion`
      },
      disabled () {
        return this.policyDefinition.roleGrants[this.roleName][this.action] === 'DENIED'
      }
    },
    watch: {
    },
    methods: {
      addColumnExclusion() {
        this.dialog = false
        const actionRoleColumnExclusions = (this.policyDefinition.columnExclusions[this.action][this.roleName] || [])
          .filter(ce => ce !== this.columnName)
          .concat(
            [
              this.columnName
            ]
          )

        try {
          this.$store.commit('savePolicy', {
            policy: {
              ...this.policyDefinition,
              columnExclusions: {
                ...this.policyDefinition.columnExclusions,
                [this.action]: {
                  ...this.policyDefinition.columnExclusions[this.action],
                  [this.roleName]: actionRoleColumnExclusions
                }
              }
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