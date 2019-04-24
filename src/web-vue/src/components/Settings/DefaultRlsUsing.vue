<template>
  <v-container>
    <v-toolbar>
      <v-btn
        @click="save"
      >Save</v-btn>
    </v-toolbar>
    <v-textarea
      v-model="defaultRlsUsing"
      auto-grow
      hide-details
      background-color="black"
    >
    </v-textarea>
    <hr>
  </v-container>
</template>

<script>
export default {
  name: 'DefaultRlsUsingClause',
  computed: {
    defaultDefaultRlsUsing () {
      return this.$store.state.defaultRlsUsing
    }
  },
  methods: {
    save () {
      this.$store.commit('updateDefaultRlsUsing', {defaultRlsUsing: this.defaultRlsUsing})
    },
    load () {
      this.defaultRlsUsing = this.defaultDefaultRlsUsing
    }
  },
  data () {
    return {
      defaultRlsUsing: null
    }
  },
  mounted () {
    this.load()
  }
}
</script>

