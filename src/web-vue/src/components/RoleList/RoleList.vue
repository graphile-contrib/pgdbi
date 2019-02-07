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
  import EnabledRoleListMixin from '@/components/RoleList/EnabledRoleListMixin.vue'

  export default {
    name: 'RoleList',
    mixins: [
      EnabledRoleListMixin
    ],
    computed: {
      selectedRoles () {
        return this.$store.state.roleFilter
      }
    },
    data: () => ({
      active: [],
      items: [],
      allEnabledRoles: []
    }),
    methods: {
      computeItems () {
        const rolesToDisplay = this.selectedRoles.length === 0 || this.filterMode ? this.allEnabledRoles : this.allEnabledRoles.filter(
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
      },
      allEnabledRoles () {
        this.computeItems()
      }
    },
  }
</script>

<style>

</style>
