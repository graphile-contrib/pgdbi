<template>
  <v-container
    ma-0 
    pa-0
  >
    <h1>Select schema to work with in the filter to the left to get started</h1>
  </v-container>
</template>

<script>
  export default {
    name: 'Initialize',
    components: {
    },
    props: {
    },
    computed: {
      initializing () {
        return this.$store.state.initializing
      }
    },
    data: () => ({
      activeTab: null
    }),
    watch: {
      initializing () {
        if (this.initializing !== true) {
          this.$router.push({name:'role-manager'})
        }
      }
    },
    beforeRouteLeave (to, from, next) {
      if (this.initializing) {
        next(false)
      } else {
        next()
      }
    }
  }
</script>

<style>

</style>
