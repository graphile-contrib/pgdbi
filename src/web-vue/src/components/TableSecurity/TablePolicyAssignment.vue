<template>
    <div>
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
                <td><policy-assignment-dialog :currentPolicyDefinition="props.item.policyDefinition" :table="props.item"></policy-assignment-dialog></td>
              </tr>
            </template>

            <template slot="expand" slot-scope="props">
              <policy-definition
                :policyId="props.item.policyDefinition.id"
                :table="props.item"
              ></policy-definition>
            </template>
          </v-data-table>
        </v-tab-item>
      </v-tabs>
    </div>
</template>

<script>
  import PolicyDefinition from '@/components/TableSecurity/TablePolicyDefinition'
  import PolicyAssignmentDialog from '@/components/TableSecurity/TablePolicyAssignmentDialog'

  export default {
    name: 'PolicyAssignment',
    components: {
      PolicyDefinition,
      PolicyAssignmentDialog
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
        return this.$store.state.managedSchemata
          .map(
            schema => {
              return {
                ...schema,
                schemaTables: schema.schemaTables.map(
                  table => {
                    const policyDefinition = this.policies.find(p => p.id === table.policyDefinitionId)
                    if (!policyDefinition) {
                      console.log(table.name, table.policyDefinitionId, this.policies)
                      console.log('pd', policyDefinition.id)
                    }
                    return {
                      ...table,
                      policyDefinition: policyDefinition
                    }
                  }
                ).sort((a,b)=>{ return a.name < b.name ? -1 : 1})
              }
            }
          ).sort((a,b)=>{ return a.schemaName < b.schemaName ? -1 : 1})
        
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
          text: 'Policy Name',
          sortable: false,
        },
      ]
    })
  }
</script>