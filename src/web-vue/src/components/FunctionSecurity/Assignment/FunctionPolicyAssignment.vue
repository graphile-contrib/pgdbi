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
          <function-policy-assignment-schema
            :schema="schema"
          >
          </function-policy-assignment-schema>
        </v-tab-item>
      </v-tabs>
    </div>
</template>

<script>
  import PolicyDefinition from '@/components/FunctionSecurity/Definition/FunctionPolicyDefinition'
  import PolicyAssignmentDialog from '@/components/FunctionSecurity/Assignment/FunctionPolicyAssignmentDialog'
  import FunctionPolicyAssignmentSchema from '@/components/FunctionSecurity/Assignment/FunctionPolicyAssignmentSchema'

  export default {
    name: 'FunctionAssignment',
    components: {
      PolicyDefinition,
      PolicyAssignmentDialog,
      FunctionPolicyAssignmentSchema
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
                    }
                    return {
                      ...aFunction,
                      policyDefinition: policyDefinition
                    }
                  }
                ).sort((a,b)=>{ return a.functionname < b.functionname ? -1 : 1})
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