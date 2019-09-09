<template>
  <v-app id="inspire">
    <v-hover v-slot:default="{ hover }">
      <v-navigation-drawer
        v-model="drawer"
        :clipped="true"
        app
        :width="hover ? 500 : 200"
        disable-route-watcher
      >
        <project-navigator
        ></project-navigator>
      </v-navigation-drawer>
    </v-hover>

    <v-app-bar
      app
      clipped-left
    >
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
      <v-toolbar-title selectable v-text="title" @click="home"></v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn @click="navigate('home')" :color="btnColor('home')">Home</v-btn>
      <v-btn @click="navigate('role-manager')" :color="btnColor('role-manager')">Roles</v-btn>
      <v-btn @click="navigate('table-security-manager')" :color="btnColor('table-security-manager')">Table Security</v-btn>
      <v-btn @click="navigate('function-security-manager')" :color="btnColor('function-security-manager')">Function Security</v-btn>
      <v-btn @click="navigate('fk-index-manager')" :color="btnColor('fk-index-manager')">Indexes</v-btn>
      <v-btn @click="navigate('search-view')" :color="btnColor('search-view')">Function Search</v-btn>
      <v-btn @click="navigate('worker')" :color="btnColor('worker')" :hidden="disableGraphileWorker">Worker</v-btn>
      <v-btn @click="navigate('sqitch')" :color="btnColor('sqitch')" :hidden="disableSqitch">Sqitch</v-btn>
      <v-spacer></v-spacer>
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
    </v-app-bar>

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
import bus from './AppBus'
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
    currentRoute () {
      return this.$router.currentRoute
    },
    disableGraphileWorker () {
      return this.$store.state.pgdbiOptions.enableGraphileWorker !== true
    },
    disableSqitch () {
      return this.$store.state.pgdbiOptions.enableSqitch !== true
    }
  },
  methods: {
    // focusToRoute () {
    //   this.expandNav = false
    //   this.drawer = false
    // },
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
      drawer: true,
      fixed: false,
      items: [],
      miniVariant: false,
      right: true,
      rightDrawer: false,
      title: 'pg-db-inspector'
    }
  },
  created () {
    this.$vuetify.theme.dark = true
    bus.$on('focus-route', this.focusToRoute)
  },
}
</script>