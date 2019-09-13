<template>
  <v-container
    ma-0 
    pa-0
  >
    <h1>Select schema to work with in the filter to the left to get started</h1>
    <h2>or...</h2>
    <project-import></project-import>
  </v-container>
</template>

<script>
  import ProjectImport from '@/components/Project/ProjectImport'

  export default {
    name: 'Initialize',
    components: {
      ProjectImport
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
          this.$router.push({name:'security-manager'})
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
