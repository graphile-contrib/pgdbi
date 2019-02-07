<template>
  <v-container>
    <v-btn @click="apply" :disabled="applyDisabled">Apply</v-btn>
    <v-treeview
      :items="items"
      transition
      :selectable="true"
      v-model="selected"
    ></v-treeview>
 </v-container>
</template>

<script>
  import allEnabledRoles from '@/gql/query/allEnabledRoles.graphql';

  export default {
    name: 'RoleFilter',
    computed: {
      applyDisabled () {
        const existingFilters = this.$store.state.roleFilter || []
        const allExistingFiltersPresent = existingFilters.reduce(
          (result, roleName) => {
            return result ? this.selected.indexOf(roleName) > -1 : false
          }, true
        )
        return allExistingFiltersPresent && (existingFilters.length === this.selected.length)
      }
    },
    data: () => ({
      items: [],
      roles: [],
      selected: [],
      selectedRoles: []
    }),
    methods: {
      apply () {
        this.$store.commit('roleFilter', { roleFilter: this.selected })
      },
      computeItems () {
        const selectedRoles = this.$store.state.roleFilter || []
        const rolesToDisplay = this.roles

        this.items = rolesToDisplay.map(
          role => {
            return {
              id: `${role.roleName}`,
              name: role.roleName,
              children: []
            }
          }
        )

        this.selected = selectedRoles
      },
    },
    apollo: {
      init: {
        query: allEnabledRoles,
        update (result) {
          this.roles = result.allEnabledRoles.nodes
          this.computeItems()
        }
      }
    }
  }
</script>

<style>

</style>
