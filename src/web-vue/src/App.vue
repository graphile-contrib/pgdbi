<template>
  <v-app dark>
    <v-navigation-drawer
      persistent
      :mini-variant="miniVariant"
      :clipped="clipped"
      v-model="drawer"
      enable-resize-watcher
      width="400"
      app
    >
    <project-navigator></project-navigator>
    </v-navigation-drawer>
    <v-toolbar
      app
      :clipped-left="clipped"
    >
      <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
      <div>
        <v-toolbar-title selectable v-text="title" @click="home"></v-toolbar-title>
      </div>
      <v-spacer></v-spacer>
      <v-btn @click="navigate('home')" :color="btnColor('home')">Home</v-btn>
      <v-spacer></v-spacer>
      <v-btn @click="navigate('role-manager')" :color="btnColor('role-manager')">Roles</v-btn>
      <v-btn @click="navigate('table-security-manager')" :color="btnColor('table-security-manager')">Table Security</v-btn>
      <v-spacer></v-spacer>
      <v-btn @click="navigate('function-security-manager')" :color="btnColor('function-security-manager')">Function Security</v-btn>
      <v-spacer></v-spacer>
      <v-spacer></v-spacer>
      <v-btn @click="navigate('fk-index-manager')" :color="btnColor('fk-index-manager')">Indexes</v-btn>
      <v-spacer></v-spacer>
      <v-spacer></v-spacer>
      <v-btn @click="navigate('search-view')" :color="btnColor('search-view')">Search</v-btn>
      <!-- <v-btn @click="navigate('smart-comment-manager')" :color="btnColor('smart-comment-manager')">Schemutators</v-btn> -->
      <v-spacer></v-spacer>
      <v-spacer></v-spacer>
      <v-spacer></v-spacer>
      <v-btn icon @click.stop="settings">
        <v-icon>settings</v-icon>
      </v-btn>
    </v-toolbar>
    <v-content>
      <v-container
        justify-start
         ma-0 
         pa-0
      >
        <router-view></router-view>
      </v-container>
    </v-content>
    <v-footer :fixed="fixed" app>
      <span>&copy; 2017</span>
    </v-footer>
  </v-app>
</template>

<script>
import ProjectNavigator from '@/components/Project/ProjectNavigator'

export default {
  name: 'App',
  components: { 
    ProjectNavigator
  },
  computed: {
    currentRoute () {
      return this.$router.currentRoute
    }
  },
  methods: {
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
  // mounted () {
  //   console.log(this.currentRoute)
  // }
}
</script>

<style lang="css">
  .treeview-label { background-color: #494544; }

  .selectable { cursor: pointer; }

  .v-content .container { height: 100%; }
  .v-content .container > .layout { height: 100%; }
  .v-content .container > .layout .v-card.theme--dark { 	height: 100%; }
  .v-content .container > .layout .v-card.theme--dark .grid-list-md .row.wrap.layout { 	height: 100%; }
  .graphiql-parent { 	height: 90%; }
</style>