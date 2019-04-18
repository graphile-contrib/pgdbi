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
          <policy-assignment-schema :schema="schema"></policy-assignment-schema>
        </v-tab-item>
      </v-tabs>
    </div>
</template>

<script>
  import PolicyAssignmentSchema from './TablePolicyAssignmentSchema.vue'

  export default {
    name: 'PolicyAssignment',
    components: {
      PolicyAssignmentSchema
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
      mappedSchemata: []
    })
  }
</script>