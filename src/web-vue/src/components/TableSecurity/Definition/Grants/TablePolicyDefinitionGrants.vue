<template>
    <v-tabs
      v-model="activeTab"
      dark
    >
      <v-tab
        key="grants"
        ripple
      >
        Role Grants
      </v-tab>
      <v-tab-item
        key="grants"
        lazy
      >
        <v-card flat>
        <table-policy-definition-grant-grid
          :policyDefinition="policyDefinition"
          :disabled="disabled"
        ></table-policy-definition-grant-grid>
        </v-card>
      </v-tab-item>

      <v-tab
        key="exclusions"
        ripple
        :disabled="disabled"
    >
        Column Exclusions
      </v-tab>
      <v-tab-item
        key="exclusions"
        lazy
      >
        <v-card flat>
          <table-policy-definition-column-exclusions
            :policyDefinition="policyDefinition"
            :table="table"
            :disabled="disabled"
          ></table-policy-definition-column-exclusions>
        </v-card>
      </v-tab-item>
    </v-tabs>
</template>

<script>
  import TablePolicyDefinitionGrantGrid from '@/components/TableSecurity/Definition/Grants/TablePolicyDefinitionGrantGrid.vue'
  import TablePolicyDefinitionColumnExclusions from '@/components/TableSecurity/Definition/Grants/TablePolicyDefinitionColumnExclusions.vue'

  export default {
    name: 'PolicyDefinitionGrants',
    components: {
      TablePolicyDefinitionGrantGrid,
      TablePolicyDefinitionColumnExclusions
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
        activeTab: null
      }
    },
    watch: {
    },
    methods: {
    },
    computed: {
    },
  }
</script>