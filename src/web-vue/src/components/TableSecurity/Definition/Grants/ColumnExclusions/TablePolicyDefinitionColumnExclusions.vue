<template>
  <v-container justify-start>
    <v-data-table
      :headers="headers"
      :items="dataTableItems"
      hide-default-footer
      dense
    >
    <template v-slot:item.insertExclusions="{ item }">
      <column-exclusion-set
        :policyDefinition="policyDefinition"
        :table="table"
        :action="'insert'"
        :roleName="item.roleName"
      ></column-exclusion-set>
    </template>

    <template v-slot:item.updateExclusions="{ item }">
      <column-exclusion-set
        :policyDefinition="policyDefinition"
        :table="table"
        :action="'update'"
        :roleName="item.roleName"
      ></column-exclusion-set>
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
            text: 'Role Name',
            sortable: false,
            value: 'roleName'
          },
          {
            text: 'Insert Exclusions',
            sortable: false,
            value: 'insertExclusions'
          },
          {
            text: 'Update Exclusions',
            sortable: false,
            value: 'updateExclusions'
          },
        ]
      }
    },
    watch: {
    },
    methods: {
      removeInsertExclusion (columnExclusion, roleName) {
        console.log('columnExclusion', columnExclusion, roleName)
      }
    },
    computed: {
      dbUserRoles () {
        return this.$store.state.roleSet.dbUserRoles
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