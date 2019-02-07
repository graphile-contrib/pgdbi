<template>
  <v-container>
    <v-treeview
      :items="items"
      activatable
      transition
      :active.sync="active"
    ></v-treeview>
</v-container>
</template>

<script>
  import allEnabledRoles from '@/gql/query/allEnabledRoles.graphql';

  export default {
    name: 'RoleList',
    computed: {
      selectedRoles () {
        return this.$store.state.roleFilter
      }
    },
    data: () => ({
      active: [],
      items: [],
      roles: []
    }),
    methods: {
      computeItems () {
        const rolesToDisplay = this.selectedRoles.length === 0 || this.filterMode ? this.roles : this.roles.filter(
            r => {
              return this.selectedRoles.indexOf(r.roleName) > -1
            }
          )

          this.items = rolesToDisplay.map(
            role => {
              return {
                id: `${role.roleName}`,
                name: role.roleName,
                children: []
              }
            }
          )
      }
    },
    watch: {
      selectedRoles () {
        this.computeItems()
      }
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
