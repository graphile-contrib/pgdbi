<template>
  <v-container
    ma-5
    pa-5
  >
    <v-tabs
      v-model="activeTab"
      dark
    >      
      <v-tab
        key="initialize"
        ripple
      >
        Initialize Project
      </v-tab>
      <v-tab-item
        key="initialize"
      >
        <v-card>
          <roles></roles>
        </v-card>
      </v-tab-item>
      <v-tab
        key="import"
        ripple
      >
        Load From Disk
      </v-tab>
      <v-tab-item
        key="import"
      >
        <v-card>
          <v-btn @click="loadFromDisk">Load From Disk</v-btn>
        </v-card>
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>

<script>
  import ProjectImport from '@/components/Project/ProjectImport'
  import Roles from '@/components/Role/Roles'
  

  export default {
    name: 'Initialize',
    components: {
      ProjectImport,
      Roles
    },
    props: {
    },
    computed: {
      initializing () {
        return this.$store.state.initializing
      }
    },
    data: () => ({
      activeTab: null,
    }),
    methods: {
      loadFromDisk () {
        this.$store.dispatch('loadFromDisk')
      }
    },
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
