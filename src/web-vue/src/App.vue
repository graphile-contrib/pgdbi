<template>
  <v-app>
    <v-app-bar
      app
      clipped-left
    >
      <v-btn :class="refreshBtnClass" :color="refreshBtnColor" @click="refreshSchemata" :hidden="initializing">Refresh Schemata</v-btn>
      <v-spacer></v-spacer>
      <v-toolbar-title selectable v-text="title" @click="home"></v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn @click="navigate('home')" :color="btnColor('home')">Project</v-btn>
      <!-- <v-btn @click="navigate('role-manager')" :color="btnColor('role-manager')">Role Manager</v-btn> -->
      <v-btn @click="navigate('security-manager')" :color="btnColor('security-manager')" :disabled="initializing">Security Scripts</v-btn>
      <!-- <v-btn @click="navigate('fk-index-manager')" :color="btnColor('fk-index-manager')" :disabled="initializing">Constraints And Indices</v-btn> -->
      <v-btn @click="navigate('search-view')" :color="btnColor('search-view')" :disabled="initializing">Function Search</v-btn>
      <v-btn @click="navigate('pg-lint')" :color="btnColor('pg-lint')" :disabled="initializing">PG-Lint</v-btn>
      <!-- <v-btn @click="navigate('worker')" :color="btnColor('worker')" :hidden="disableGraphileWorker">Worker</v-btn>
      <v-btn @click="navigate('sqitch')" :color="btnColor('sqitch')" :hidden="disableSqitch">Sqitch</v-btn> -->
      <v-spacer></v-spacer>
      <v-spacer></v-spacer>
      <v-spacer></v-spacer>
      <v-spacer></v-spacer>
      <v-spacer></v-spacer>
      <v-spacer></v-spacer>
      <v-spacer></v-spacer>
      <v-spacer></v-spacer>
      <v-btn icon @click.stop="settings">
        <v-icon>settings</v-icon>
      </v-btn>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
    </v-app-bar>

    <v-hover v-slot:default="{ hover }">
      <v-navigation-drawer
        v-model="drawer"
        app
        right
        :width="400"
        disable-route-watcher
      >
        <project-navigator
        ></project-navigator>
      </v-navigation-drawer>
    </v-hover>

    <v-content>
      <v-container
        justify-start
         ma-0 
         pa-0
      >
        <router-view></router-view>
      </v-container>
    </v-content>

    <v-footer app>
      <span>&copy; 2019</span>
    </v-footer>
  </v-app>
</template>

<script>
import dbIntrospection from '@/gql/query/dbIntrospection.graphql'
import ProjectNavigator from '@/components/Project/ProjectNavigator'

export default {
  name: 'App',
  props: {
    source: String,
  },
  components: { 
    ProjectNavigator
  },
  computed: {
    initializing () {
      return this.$store.state.initializing
    },
    currentRoute () {
      return this.$router.currentRoute
    },
    disableGraphileWorker () {
      return (this.$store.state.pgdbiOptions || {enableGraphileWorker: false}).enableGraphileWorker !== true
    },
    disableSqitch () {
      return (this.$store.state.pgdbiOptions || {enableSqitch: false}).enableSqitch !== true
    }
  },
  watch: {
    initializing () {
      this.setRefreshBtnClass()
    }
  },
  methods: {
      setRefreshBtnClass () {
        this.refreshBtnClass = this.initializing ? 'refreshBtnInitializing' : 'refreshBtn' 
        this.refreshBtnColor = this.initializing ? 'yellow darken-3' : 'blue-grey' 
      },
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
          // this.$store.commit('setManagedSchemata', result.data.dbIntrospection.schemaTree)
          // this.$store.commit('setPgdbiOptions', {pgdbiOptions: result.data.pgdbiOptions})
          this.$loading(false)
        })
        .catch(error => {
          this.$loading(false)
          console.error(error)
          alert(error.toString())
        })
      },
    btnColor (routeName) {
      return this.$router.currentRoute.name === routeName ? 'blue' : 'blue-grey'
    },
    home () {
      this.$router.push({ name: 'home' })
    },
    settings () {
      this.$router.push({ name: 'settings' })
    },
    navigate (routeName) {
      this.$router.push({name: routeName})
    }
 },
  data () {
    return {
      expandNav: false,
      clipped: true,
      drawer: false,
      fixed: false,
      items: [],
      miniVariant: false,
      right: true,
      rightDrawer: false,
      title: 'pg-db-inspector',
      refreshBtnClass: 'refreshBtn',
      refreshBtnColor: 'blue-grey'
    }
  },
  mounted() {
    this.setRefreshBtnClass()
  },
  created () {
    // console.log('owjei', this.$vuetify.theme.themes.dark)
    // this.$vuetify.theme.primary = true
    this.$vuetify.theme.dark = true
    // bus.$on('focus-route', this.focusToRoute)
  },
}
</script>