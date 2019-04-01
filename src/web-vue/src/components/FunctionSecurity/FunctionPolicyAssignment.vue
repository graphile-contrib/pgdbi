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
            :items="schema.schemaFunctions"
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
                <td><policy-assignment-dialog :currentPolicyDefinition="props.item.policyDefinition" :theFunction="props.item"></policy-assignment-dialog></td>
              </tr>
            </template>

            <template slot="expand" slot-scope="props">
              <policy-definition
                :policyId="props.item.policyDefinition.id"
                :theFunction="props.item"
              ></policy-definition>
            </template>
          </v-data-table>
        </v-tab-item>
      </v-tabs>
    </div>
</template>

<script>
  import PolicyDefinition from '@/components/FunctionSecurity/FunctionPolicyDefinition'
  import PolicyAssignmentDialog from '@/components/FunctionSecurity/FunctionPolicyAssignmentDialog'

  export default {
    name: 'FunctionAssignment',
    components: {
      PolicyDefinition,
      PolicyAssignmentDialog
    },
    methods: {
    },
    watch: {
    },
    computed: {
      functionPolicies () {
        return this.$store.state.functionPolicies
      },
      managedSchemata () {
        return this.$store.state.managedSchemata
          .map(
            schema => {
              return {
                ...schema,
                schemaFunctions: schema.schemaFunctions.map(
                  aFunction => {
                    const policyDefinition = this.functionPolicies.find(p => p.id === aFunction.functionPolicyDefinitionId)
                    if (!policyDefinition) {
                      console.log(aFunction.name, aFunction.functionPolicyDefinitionId, this.functionPolicies)
                      console.log('pd', policyDefinition)
                    }
                    return {
                      ...aFunction,
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
          text: 'Function Name',
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