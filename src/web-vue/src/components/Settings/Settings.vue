<template>
  <v-container>
    <v-tabs
      v-model="activeTab"
      dark
    >
      <v-tab
        key="roles"
        ripple
      >
        Roles
      </v-tab>
      <v-tab-item
        key="roles"
      >
        <v-card>
          <v-layout row wrap>
            <v-flex xs12>
              <v-card key="roles">
                <role-filter></role-filter>
              </v-card>
            </v-flex>
          </v-layout>
        </v-card>
      </v-tab-item>
      <v-tab
        key="schemata"
        ripple
      >
        Schemata
      </v-tab>
      <v-tab-item
        key="schemata"
      >
        <v-card>
          <v-layout row wrap>
            <v-spacer></v-spacer>
            <v-flex xs4>
              <v-card key="schemata">
                Schemata
                <schema-filter></schema-filter>
              </v-card>
            </v-flex>
            <v-spacer></v-spacer>
          </v-layout>
        </v-card>
      </v-tab-item>
      <v-tab
        key="policies"
        ripple
      >
        Policies
      </v-tab>
      <v-tab-item
        key="policies"
      >
        <v-card>
          POLICIES
        </v-card>
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>

<script>
  import RoleFilter from '@/components/RoleList/RoleFilter'
  import SchemaFilter from '@/components/SchemaTree/SchemaFilter'

  export default {
    name: 'Settings',
    components: {
      RoleFilter,
      SchemaFilter
    },
    props: {
    },
    computed: {
    },
    data: () => ({
      activeTab: null
    }),
    apollo: {
    }
  }
</script>

<style>

</style>
