<template>
  <v-container>
    <v-toolbar>
      <v-btn
        @click="save"
        :disabled="disabled"
      >Save</v-btn>
      <h2>Default RLS Using Clause</h2>
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
    },
    disabled () {
      return this.defaultRlsUsing === this.defaultDefaultRlsUsing
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

