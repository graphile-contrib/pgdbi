<template>
  <v-container>
    <table-policy-column-exclusion-dialog
      :policyDefinition="policyDefinition"
      :table="table"
    >
    </table-policy-column-exclusion-dialog>
    <hr>
    <v-data-table
      :items="policyDefinition.columnExclusions"
      hide-headers
      hide-actions
      class="text-sm-left"
    >
      <template slot="items" slot-scope="props">
        <td>{{ props.item }}</td>
        <td><v-btn @click="removeColumnExclusion(props.item)">Remove</v-btn></td>
      </template>
    </v-data-table>
  </v-container>
</template>

<script>
  import TablePolicyColumnExclusionDialog from '@/components/TableSecurity/Dialogs/TablePolicyColumnExclusionDialog.vue'

  export default {
    name: 'PolicyDefinitionColumnExclusions',
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
      }
    },
    data () {
      return {
      }
    },
    watch: {
    },
    methods: {
      removeColumnExclusion (columnExclusion) {
        const columnExclusions = this.policyDefinition.columnExclusions.filter(ce => ce !== columnExclusion)

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
    },
    computed: {
    }
  }
</script>