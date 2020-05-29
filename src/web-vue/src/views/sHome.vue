<template>
  <v-container>
    <v-tabs
      v-model="activeTab"
      dark
    >
 
      <v-tab
        key="home"
        ripple
      >
        Home
      </v-tab>
      <v-tab-item
        key="home"
      >
        <v-card>
          <new-home></new-home>
        </v-card>
      </v-tab-item>
 
       <v-tab
        key="help"
        ripple
      >
        Help
      </v-tab>
      <v-tab-item
        key="help"
      >
        <v-card>
          TODO: Make help pages/videos
        </v-card>
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>

<script>
  import NewHome from './NewHome'

  export default {
    name: 'Home',
    components: {
      NewHome
    },
    props: {
    },
    computed: {
    },
    data: () => ({
      activeTab: null
    }),
    methods: {
      resetStore () {
        this.$store.commit('resetDefaultState')
        this.$router.push('initialize')
      }
    }
  }
</script>

<style>

</style>
