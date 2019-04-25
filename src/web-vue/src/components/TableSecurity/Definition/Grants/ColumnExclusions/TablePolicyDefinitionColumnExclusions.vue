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
          <column-exclusion-set
            :policyDefinition="policyDefinition"
            :table="table"
            :action="'insert'"
            :roleName="props.item.roleName"
          ></column-exclusion-set>
        </td>
        <td>
          <column-exclusion-set
            :policyDefinition="policyDefinition"
            :table="table"
            :action="'update'"
            :roleName="props.item.roleName"
          ></column-exclusion-set>
        </td>
      </template>
    </v-data-table>
  </v-container>
</template>

<script>
  import { mapGetters } from 'vuex'
  import ColumnExclusionSet from '@/components/TableSecurity/Definition/Grants/ColumnExclusions/ColumnExclusionSet.vue'

  export default {
    name: 'PolicyDefinitionColumnExclusions',
    components: {
      ColumnExclusionSet
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
      // toggleInsert(columnExclusion) {
      //   if (this.toggleComplete) {
      //     this.toggleComplete = false
      //     return
      //   } else {
      //     const updatedColumnExclusions = this.policyDefinition.columnExclusions
      //       .filter(ce => ce.columnName !== columnExclusion.columnName)
      //       .concat([
      //         {
      //           ...columnExclusion,
      //           excludeForInsert: !columnExclusion.excludeForInsert
      //         }
      //       ])

      //     const updatedPolicy = {
      //       ...this.policyDefinition,
      //       columnExclusions: updatedColumnExclusions

      //     }

      //     this.$store.commit('savePolicy', { policy: updatedPolicy })

      //     this.toggleComplete = true
      //   }
      // },
      // toggleUpdate(columnExclusion) {
      //   if (this.toggleComplete) {
      //     this.toggleComplete = false
      //     return
      //   } else {
      //     const updatedColumnExclusions = this.policyDefinition.columnExclusions
      //       .filter(ce => ce.columnName !== columnExclusion.columnName)
      //       .concat([
      //         {
      //           ...columnExclusion,
      //           excludeForUpdate: !columnExclusion.excludeForUpdate
      //         }
      //       ])

      //     const updatedPolicy = {
      //       ...this.policyDefinition,
      //       columnExclusions: updatedColumnExclusions

      //     }

      //     this.$store.commit('savePolicy', { policy: updatedPolicy })

      //     this.toggleComplete = true
      //   }
      // },
      removeInsertExclusion (columnExclusion, roleName) {
        console.log('columnExclusion', columnExclusion, roleName)

        // const remainingInsertExclusions = this.policyDefinition.columnExclusion.insert[roleName].filter(ice => ice !== columnExclusion)

        // try {
        //   this.$store.commit('savePolicy', {
        //     policy: {
        //       ...this.policyDefinition,
        //       columnExclusions: {
        //         ...this.policyDefinition.columnExclusions,
        //         [this.action]: {
        //           ...this.policyDefinition.columnExclusions[this.action],
        //           [this.roleName]: actionRoleColumnExclusions
        //         }
        //       }
        //     }
        //   })
        // }
        // catch (e) {
        //   alert(e.toString())
        //   console.error(e)
        // }
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
              const insertExclusions = (this.policyDefinition.columnExclusions.insert || [])[roleName] || []
              const updateExclusions = (this.policyDefinition.columnExclusions.update || [])[roleName] || []
      
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