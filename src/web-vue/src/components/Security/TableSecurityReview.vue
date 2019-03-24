<template>
  <div>
    <v-tabs
      dark
      slider-color="yellow"
    >
      <v-tab
        key="rls-policies"
        ripple
      >
        Rls Policies
      </v-tab>
      <v-tab-item
        key="rls-policies"
      >
        <v-card color="blue">
          <v-container>
            <table-policies
              :policies="props.item.policies"
            ></table-policies>
          </v-container>
        </v-card>
      </v-tab-item>

      <v-tab
        key="table-grants"
        ripple
      >
        Table Grants
      </v-tab>
      <v-tab-item
        key="table-grants"
      >
        <v-card color="blue">
          <v-container>
            <table-grants
              :grants="props.item.roleTableGrants"
            ></table-grants>
          </v-container>
        </v-card>
      </v-tab-item>
    </v-tabs>
  </div>
</template>

<script>
  import TablePolicies from '@/components/Table/TablePolicies'
  import TableGrants from '@/components/Table/TableGrants'
  import PolicyDefinition from '@/components/Policy/PolicyDefinition'

  export default {
    name: 'TableSecurityReview',
    components: {
      TablePolicies,
      TableGrants,
      PolicyDefinition
    },
    props: {
    },
    computed: {
    },
    methods: {
    },
    watch: {
    },
    data: () => ({
    })
  }
</script>

<style>

</style>
