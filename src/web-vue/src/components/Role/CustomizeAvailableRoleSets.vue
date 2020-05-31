<template>
  <v-container>
    <v-toolbar>
      <v-btn @click="saveAllRoleSets">Save</v-btn>
    </v-toolbar>
    <v-textarea
      v-model="allRolesJsonText"
      auto-grow
      spellcheck="false"
      background-color="black"
    ></v-textarea>
  </v-container>
</template>

<script>
  export default {
    name: 'CustomizeAvailableRoleSets',
    mixins: [
    ],
    components: {
    },
    props: {
    },
    data () {
      return {
        allRolesJsonText: ''
      }
    },
    watch: {
      allRoleSets () {
        this.computeContent()
      }
    },
    methods: {
      computeContent () {
        this.allRolesJsonText = JSON.stringify(this.allRoleSets,0,2)
      },
      saveAllRoleSets () {
        const allRoleSets = JSON.parse(this.allRolesJsonText)
        this.$store.commit('setAllRoleSets', allRoleSets)
      }
    },
    computed: {
      allRoleSets () {
        return this.$store.state.allRoleSets
      }
    },
    mounted () {
      this.computeContent()
    }
  }
</script>