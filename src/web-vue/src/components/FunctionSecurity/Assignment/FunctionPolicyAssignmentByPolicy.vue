<template>
    <v-container>
      <v-expansion-panels
        dark
        slider-color="yellow"
      >
        <v-expansion-panel
          v-for="policy in mappedPolicies"
          :key="policy.id"
          ripple
        >
        <v-expansion-panel-header>
          ({{ policy.numberOfAssignments }}) - {{ policy.name }}
        </v-expansion-panel-header>
        <v-expansion-panel-content v-if="policy.numberOfAssignments > 0">
          <function-policy-assignment-policy :policyDefinitionId="policy.id"></function-policy-assignment-policy>
        </v-expansion-panel-content>
        <v-expansion-panel-content v-else>
          <h2>No assignments for this policy</h2>
        </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </v-container>
</template>

<script>
  import FunctionPolicyAssignmentPolicy from './FunctionPolicyAssignmentPolicy.vue'

  export default {
    name: 'FunctionPolicyAssignmentByPolicy',
    components: {
      FunctionPolicyAssignmentPolicy
    },
    methods: {
    },
    watch: {
    },
    computed: {
      mappedPolicies () {
        return this.policies.map(p => {
          const numberOfAssignments = Object.keys(this.functionPolicyAssignments).reduce(
            (all, functionId) => {
              return this.functionPolicyAssignments[functionId].policyDefinitionId === p.id ? all+1 : all
            }, 0
          )
          return {
            ...p,
            numberOfAssignments: numberOfAssignments
          }
        })

      },
      policies () {
        return this.$store.state.functionPolicies
      },
      functionPolicyAssignments () {
        return this.$store.state.functionPolicyAssignments
      }
    },
    data: () => ({
      mappedSchemata: []
    })
  }
</script>