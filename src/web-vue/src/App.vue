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
      <v-btn @click="$router.push({name:'home'})">Home</v-btn>
      <v-btn @click="$router.push({name:'security-manager'})">Table Security</v-btn>
      <v-btn @click="$router.push({name:'function-security-manager'})">Function Security</v-btn>
      <v-btn @click="$router.push({name:'fk-index-manager'})">Indexes</v-btn>
      <v-btn @click="$router.push({name:'smart-comment-manager'})">Smart Comments</v-btn>
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
    <!-- <v-navigation-drawer
      persistent
      :mini-variant="miniVariant"
      :clipped="clipped"
      v-model="rightDrawer"
      :right="right"
      enable-resize-watcher
      width="400"
      app
    >
    </v-navigation-drawer> -->
    <v-footer :fixed="fixed" app>
      <span>&copy; 2017</span>
    </v-footer>
  </v-app>
</template>

<script>
import ProjectNavigator from './components/ProjectNavigator'

export default {
  name: 'App',
  components: { 
    ProjectNavigator
  },
  methods: {
    home () {
      this.$router.push({ name: 'home' })
    },
    settings () {
      this.$router.push({ name: 'settings' })
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
  // created () {
  //   this.$store.commit('initialize')
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