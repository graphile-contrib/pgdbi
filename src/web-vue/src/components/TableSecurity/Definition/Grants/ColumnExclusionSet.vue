<template>
  <v-container>
    <table-policy-column-exclusion-dialog
      :policyDefinition="policyDefinition"
      :table="table"
      :action="action"
      :roleName="roleName"
    >
    </table-policy-column-exclusion-dialog>
      <v-list
      >
        <v-list-tile
          v-for="ice in currentColumnExclusions"
          :key="ice"
        >
          <v-btn @click="removeColumnExclusion(ice)"><v-icon>clear</v-icon></v-btn> {{ice}}
        </v-list-tile>
      </v-list>
  </v-container>
</template>

<script>
  import { mapGetters } from 'vuex'
  import TablePolicyColumnExclusionDialog from '@/components/TableSecurity/Definition/Grants/TablePolicyColumnExclusionDialog.vue'

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
      disabled: {
        type: Boolean,
        default: false
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
        toggleComplete: false
      }
    },
    watch: {
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
    computed: {
      currentColumnExclusions () {
        return this.policyDefinition.columnExclusions[this.action][this.roleName]
      }
    }
  }
</script>