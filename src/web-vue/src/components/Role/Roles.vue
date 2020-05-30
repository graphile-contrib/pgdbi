<template>
  <v-container>
    <v-tabs
      v-model="activeTab"
      dark
    >
      <v-tab
        key="choose-role-set"
        ripple
      >
        Choose Role Set
      </v-tab>
      <v-tab-item
        key="choose-role-set"
      >
        <v-card>
          <v-layout row wrap>
            <v-flex xs12>
              <v-card key="choose-role-set">
                <choose-role-set></choose-role-set>
                <v-card-actions>
                  <v-btn :class="refreshBtnClass" :color="refreshBtnColor" @click="refreshSchemata" >Refresh Schemata</v-btn>
                </v-card-actions>
              </v-card>
            </v-flex>
          </v-layout>
        </v-card>
      </v-tab-item>
      <v-tab
        key="customize-role-set"
        ripple
      >
        Customize Available Role Sets
      </v-tab>
      <v-tab-item
        key="customize-role-set"
      >
        <v-card>
          <v-layout row wrap>
            <v-flex xs12>
              <v-card key="customize-role-set">
                <customize-available-role-sets></customize-available-role-sets>
              </v-card>
            </v-flex>
          </v-layout>
        </v-card>
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>

<script>
  const NOT_ROLE = '---'
  const INHERITS_ROLE = '+++'
  import ChooseRoleSet from './ChooseRoleSet'
  import CustomizeAvailableRoleSets from './CustomizeAvailableRoleSets'
  import dbIntrospection from '@/gql/query/dbIntrospection.graphql'

  export default {
    name: 'Roles',
    mixins: [],
    components: {
      ChooseRoleSet,
      CustomizeAvailableRoleSets
    },
    watch: {
    },
    computed: {
    },
    data () {
      return {
        activeTab: null,
          refreshBtnClass: 'refreshBtnInitializing',
          refreshBtnColor: 'yellow darken-3'
      }
    },
    methods: {
      refreshSchemata () {
        this.$loading(true)
        this.$apollo.query({
          query: dbIntrospection,
          fetchPolicy: 'network-only'
        })
        .then(result => {
          this.$store.dispatch('setManagedSchemata', {
            schemaTree: result.data.dbIntrospection.schemaTree,
            pgdbiOptions: {pgdbiOptions: result.data.pgdbiOptions}
          })
          this.$loading(false)
        })
        .catch(error => {
          this.$loading(false)
          console.error(error)
          alert(error.toString())
        })
      },
    },
    mounted () {
    }
  }
</script>

<style>

</style>
