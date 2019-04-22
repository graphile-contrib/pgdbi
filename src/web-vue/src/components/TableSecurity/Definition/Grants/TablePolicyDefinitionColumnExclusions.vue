<template>
  <v-container justify-start>
    <v-data-table
      :headers="headers"
      :items="dataTableItems"
      hide-actions
      class="text-sm-left"
    >
      <template slot="items" slot-scope="props">
        <td>{{ props.item.roleName }}</td>
        <td>
          <table-policy-column-exclusion-dialog
            :policyDefinition="policyDefinition"
            :table="table"
            :action="'insert'"
            :roleName="props.item.roleName"
          >
          </table-policy-column-exclusion-dialog>
          <v-data-table
            hide-headers
            hide-actions
            :items="props.item.insertColumnExclusions"
          >
            <template slot="items" slot-scope="props">
              <td>{{ props.item }}</td>
              <td><v-btn>Remove</v-btn></td>
            </template>
          </v-data-table>
        </td>
        <td>
          <table-policy-column-exclusion-dialog
            :policyDefinition="policyDefinition"
            :table="table"
            :action="'update'"
            :roleName="props.item.roleName"
          >
          </table-policy-column-exclusion-dialog>
          <v-data-table
            hide-headers
            hide-actions
            :items="props.item.updateColumnExclusions"
          >
            <template slot="items" slot-scope="props">
              <td>{{ props.item }}</td>
              <td><v-btn>Remove</v-btn></td>
            </template>
          </v-data-table>
        </td>
        <!-- <td><v-btn @click="removeColumnExclusion(props.item)">Remove</v-btn></td> -->
      </template>
    </v-data-table>
  </v-container>
</template>

<script>
  import { mapGetters } from 'vuex'
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
        toggleComplete: false,
        headers: [
          {
            text: 'Column Name',
            sortable: false
          },
          {
            text: 'Insert Exclusions',
            sortable: false
          },
          {
            text: 'Update Exclusions',
            sortable: false
          },
        ]
      }
    },
    watch: {
    },
    methods: {
      toggleInsert(columnExclusion) {
        if (this.toggleComplete) {
          this.toggleComplete = false
          return
        } else {
          const updatedColumnExclusions = this.policyDefinition.columnExclusions
            .filter(ce => ce.columnName !== columnExclusion.columnName)
            .concat([
              {
                ...columnExclusion,
                excludeForInsert: !columnExclusion.excludeForInsert
              }
            ])

          const updatedPolicy = {
            ...this.policyDefinition,
            columnExclusions: updatedColumnExclusions

          }

          this.$store.commit('savePolicy', { policy: updatedPolicy })

          this.toggleComplete = true
        }
      },
      toggleUpdate(columnExclusion) {
        if (this.toggleComplete) {
          this.toggleComplete = false
          return
        } else {
          const updatedColumnExclusions = this.policyDefinition.columnExclusions
            .filter(ce => ce.columnName !== columnExclusion.columnName)
            .concat([
              {
                ...columnExclusion,
                excludeForUpdate: !columnExclusion.excludeForUpdate
              }
            ])

          const updatedPolicy = {
            ...this.policyDefinition,
            columnExclusions: updatedColumnExclusions

          }

          this.$store.commit('savePolicy', { policy: updatedPolicy })

          this.toggleComplete = true
        }
      },
      removeColumnExclusion (columnExclusion) {
        const columnExclusions = this.policyDefinition.columnExclusions.filter(ce => ce.columnName !== columnExclusion.columnName)

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
      projectRoles () {
        return this.$store.state.projectRoles
      },
      dataTableItems () {
        return Object.keys(this.policyDefinition.roleGrants)
          .reduce(
            (dtItems, roleName) => {
              const applicableRoles = this.projectRoles.find(pr => pr.roleName === roleName).applicableRoles
                .map(ar => {
                  return ar.roleName
                })

              const applicableInsertExclusions = applicableRoles.reduce(
                (applicableExclusions, roleName) => {
                  const roleExclusions = (this.policyDefinition.columnExclusions.insert || [])[roleName]
                  if (roleExclusions) {
                    return applicableExclusions.concat(roleExclusions)
                  } else {
                    return applicableExclusions
                  }
                }, []
              )
              const directInsertExclusions = (this.policyDefinition.columnExclusions.insert || [])[roleName] || []
              const insertExclusions = [...applicableInsertExclusions, ...directInsertExclusions]
      
              const applicableUpdateExclusions = applicableRoles.reduce(
                (applicableExclusions, roleName) => {
                  const roleExclusions = (this.policyDefinition.columnExclusions.update || [])[roleName]
                  if (roleExclusions) {
                    return applicableExclusions.concat(roleExclusions)
                  } else {
                    return applicableExclusions
                  }
                }, []
              )
              const directUpdateExclusions = (this.policyDefinition.columnExclusions.update || [])[roleName] || []
              const updateExclusions = [...applicableUpdateExclusions, ...directUpdateExclusions]
      
              return [...dtItems, {
                roleName: roleName,
                insertColumnExclusions: insertExclusions,
                updateColumnExclusions: updateExclusions
              }]
            }, []
          )
      }
    }
  }
</script>