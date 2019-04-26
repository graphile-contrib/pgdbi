<template>
    <v-card color="black" :key="policyDefinition.id">
      <v-container>
        <v-toolbar>
          <h1>Name: {{ policyDefinition.name }}</h1>
          <v-spacer></v-spacer>
          <!-- <v-btn @click="customize" :hidden="!theFunction">customize</v-btn> -->
        </v-toolbar>
        <v-tabs
          v-model="activeTab"
          dark
        >
          <v-tab
            key="grants"
            ripple
          >
            Execution Grants
          </v-tab>
          <v-tab-item
            key="grants"
          >
            <v-card flat>
            <policy-definition-grant-grid
              :policy="policyDefinition"
              :disabled="disabled"
            ></policy-definition-grant-grid>
            </v-card>
          </v-tab-item>

          <v-tab
            key="policy-template"
            ripple
          >
            {{ theFunction ? 'Policy' : 'Policy Template'}}
          </v-tab>
          <v-tab-item
            key="policy-template"
          >
            <v-card flat>
              <policy-realization
                :policyDefinition="policyDefinition"
                :theFunction="theFunction"
              ></policy-realization>
            </v-card>
          </v-tab-item>

        </v-tabs>
      </v-container>
    </v-card>
</template>

<script>
  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'

  import PolicyDefinitionGrantGrid from '@/components/FunctionSecurity/Definition/FunctionPolicyDefinitionGrantGrid.vue'
  import PolicyRealization from '@/components/FunctionSecurity/Realization/FunctionPolicyRealization.vue'

  export default {
    name: 'FunctionPolicyDefinition',
    components: {
      PolicyDefinitionGrantGrid,
      PolicyRealization
    },
    props: {
      policyId: {
        type: Number,
        required: true
      },
      theFunction: {
        type: Object,
        required: false
      }
    },
    data () {
      return {
        calculatedPolicy: 'NOT CALCULATED',
        toggleCompleted: false,
        activeTab: ''
      }
    },
    mounted () {
    },
    watch: {
    },
    methods: {
      // customize () {
      //   alert('not implemented: will allow for in-place editing to create new custom policy')
      // }
    },
    computed: {
      disabled () {
        return (this.theFunction !== null && this.theFunction !== undefined) || this.policyDefinition.id === this.$store.state.defaultFunctionPolicy.id
      },
      policyDefinition () {
        const functionPolicies = this.$store.state.functionPolicies
        const pol = this.$store.state.functionPolicies.find(p => p.id === this.policyId)
        return pol
      }
    }
  }
</script>