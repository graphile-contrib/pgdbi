<template>
  <v-checkbox
    :input-value="isIgnored"
    @click="toggleIgnoreRole()"
    :disabled="disabled"
  ></v-checkbox>
</template>

<script>
  export default {
    name: 'IgnoreRole',
    mixins: [],
    props: {
      role: {
        type: Object,
        required: true
      }
    },
    computed: {
      disabled () {
        const projectRoleNames = this.$store.state.projectRoles.map(ir => ir.roleName)
        const retval = projectRoleNames.indexOf(this.role.roleName) !== -1
        return retval
      },
      isIgnored () {
        const ignoredRoleNames = this.$store.state.ignoredRoles.map(ir => ir.roleName)
        const retval = ignoredRoleNames.indexOf(this.role.roleName) !== -1
        return retval
      }
      // selected () {
      //   return this.$store.state.ignoredRoles.find(r => r.roleName === this.role.roleName) !== undefined
      // }
    },
    watch: {
      // selected () {
      //   console.log('selected', this.role)
      //   this.$store.commit('toggleIgnoreRole', { role: this.role })
      // }
    },
    data: () => ({
      // selected: false,
      debounce: false
    }),
    methods: {
      toggleIgnoreRole(){
        if (this.debounce) {
          this.debounce = false
          return
        }
        this.$store.commit('toggleIgnoreRole', { role: this.role })
        this.debounce = true
      }
    },
    mounted () {
      // this.selected = this.$store.state.ignoredRoles.find(r => r.roleName === this.role.roleName) !== undefined
    }
  }
</script>

<style>

</style>
