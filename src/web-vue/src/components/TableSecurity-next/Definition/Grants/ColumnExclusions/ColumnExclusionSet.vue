<template>
  <v-container>
    <v-switch 
      v-model="overrideActive" 
      v-if="!overrideHidden"
      :label="`override implied exclusions`"
    ></v-switch>
    <table-policy-column-exclusion-dialog
      :policyDefinition="policyDefinition"
      :table="table"
      :action="action"
      :roleName="roleName"
      v-if="showDialogButton"
    >
    </table-policy-column-exclusion-dialog>
      <v-list
      >
        <v-list-item
          v-for="ice in currentColumnExclusions"
          :key="ice"
        >
          <v-btn @click="removeColumnExclusion(ice)"><v-icon>clear</v-icon></v-btn> {{ice}}
        </v-list-item>
      </v-list>
  </v-container>
</template>

<script>
  import { mapGetters } from 'vuex'
  import TablePolicyColumnExclusionDialog from '@/components/TableSecurity/Definition/Grants/ColumnExclusions/TablePolicyColumnExclusionDialog.vue'

  export default {
    name: 'ColumnExclusionSet',
    components: {
      TablePolicyColumnExclusionDialog
    },
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
        toggleCompleted: false,
        overrideActive: false
      }
    },
    watch: {
      overrideActive () {
        let exclusions
        const otherOverrides = this.policyDefinition.columnExclusionOverrides[this.action].filter(o => o !== this.roleName)
        const newOverrides = this.overrideActive ? otherOverrides.concat(this.roleName) : otherOverrides

        if (this.overrideActive) {
          exclusions = this.policyDefinition.columnExclusions[this.action]
        } else {
          let { [this.roleName]: omit, ...exclusions } = this.policyDefinition.columnExclusions[this.action]
        }

        try {
          this.$store.commit('savePolicy', {
            policy: {
              ...this.policyDefinition,
              columnExclusionOverrides: {
                ...this.policyDefinition.columnExclusionOverrides,
                [this.action]: newOverrides
              },
              columnExclusions: {
                ...this.policyDefinition.columnExclusions,
                [this.action]: exclusions || {}
              }
            }
          })
        }
        catch (e) {
          alert(e.toString())
          console.error(e)
        }
      }
    },
    methods: {
      removeColumnExclusion (columnExclusion) {
        const remainingExclusions = this.policyDefinition.columnExclusions[this.action][this.roleName].filter(ce => ce !== columnExclusion)

        try {
          this.$store.commit('savePolicy', {
            policy: {
              ...this.policyDefinition,
              columnExclusions: {
                ...this.policyDefinition.columnExclusions,
                [this.action]: {
                  ...this.policyDefinition.columnExclusions[this.action],
                  [this.roleName]: remainingExclusions
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
    },
    mounted () {
      this.overrideActive = this.policyDefinition.columnExclusionOverrides[this.action].indexOf(this.roleName) > -1
    },
    computed: {
      currentColumnExclusions () {
        return (this.policyDefinition.columnExclusions[this.action] || [])[this.roleName]
      },
      disabled () {
        return this.policyDefinition.roleGrants[this.roleName][this.action] === 'DENIED'
      },
      overrideHidden () {
        const retval = (['DENIED', 'ALLOWED'].indexOf(this.policyDefinition.roleGrants[this.roleName][this.action])) > -1
        return retval
      },
      showDialogButton () {
        return true
        return (
          this.overrideActive && 
          this.policyDefinition.roleGrants[this.roleName][this.action] === 'IMPLIED'
        ) || 
          this.policyDefinition.roleGrants[this.roleName][this.action] === 'ALLOWED'
      }
    }
  }
</script>