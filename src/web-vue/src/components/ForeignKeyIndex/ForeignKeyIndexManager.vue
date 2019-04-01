<template>
  <v-card>
    <v-container background-color="black">
      <v-tabs
        dark
        slider-color="yellow"
      >
        <v-tab
          v-for="schema in managedSchemata"
          :key="schema.schemaName"
          ripple
        >
          {{ schema.schemaName }}
        </v-tab>
        <v-tab-item
          v-for="schema in managedSchemata"
          :key="schema.schemaName"
        >
          <v-data-table
            :headers="headers"
            :items="schema.schemaTables"
            :hide-actions="true"
          >
            <template slot="items" slot-scope="props">
              <tr @click="props.expanded = !props.expanded">
                <td>      
                  <v-btn icon @click.stop="props.expanded = !props.expanded">
                    <v-icon>{{ props.expanded ? 'expand_less' : 'expand_more' }}</v-icon>
                  </v-btn>
                </td>
                <td>{{ props.item.name }}</td>
                <!-- <td>{{ props.item.policyDefinition.name }}</td> -->
                <!-- <td><policy-assignment-dialog :currentPolicyDefinition="props.item.policyDefinition" :table="props.item"></policy-assignment-dialog></td> -->
              </tr>
            </template>

            <template slot="expand" slot-scope="props">
              <fk-index-evaluator
                :table="props.item"
              ></fk-index-evaluator>
            </template>
          </v-data-table>
        </v-tab-item>
      </v-tabs>
    </v-container>
  </v-card>
</template>

<script>
  import FkIndexEvaluator from '@/components/ForeignKeyIndex/FkIndexEvaluator.vue'
  // import PolicyAssignmentDialog from '@/components/TableSecurity/TablePolicyAssignmentDialog'

  export default {
    name: 'ForeignKeyIndexManager',
    components: {
      FkIndexEvaluator,
      // PolicyAssignmentDialog
    },
    methods: {
    },
    watch: {
    },
    computed: {
      policies () {
        return this.$store.state.policies
      },
      managedSchemata () {
        console.log('shwoijf', this.$store.state.managedSchemata)
        return this.$store.state.managedSchemata
          .map(
            schema => {
              return {
                ...schema,
                schemaTables: schema.schemaTables.map(
                  table => {
                    return table
                  //   const policyDefinition = this.policies.find(p => p.id === table.policyDefinitionId)
                  //   if (!policyDefinition) {
                  //     console.log(table.name, table.policyDefinitionId, this.policies)
                  //     console.log('pd', policyDefinition.id)
                  //   }
                  //   return {
                  //     ...table,
                  //     policyDefinition: policyDefinition
                  //   }
                  })
                  .sort((a,b)=>{ return a.name < b.name ? -1 : 1})
              }
            }
          )
          .sort((a,b)=>{ return a.schemaName < b.schemaName ? -1 : 1})
        
      },
    },
    data: () => ({
      mappedSchemata: [],
      headers: [
        {
          text: '',
          sortable: false,
        },
        {
          text: 'Table Name',
          sortable: false,
        },
        {
          text: 'WHAT COL',
          sortable: false,
        },
      ]
    })
  }
</script>