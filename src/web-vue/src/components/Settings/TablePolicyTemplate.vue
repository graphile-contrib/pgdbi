<template>
  <v-container>
    <v-toolbar>
      <v-btn
        @click="save"
      >Save</v-btn>
    </v-toolbar>
    <v-textarea
      v-model="tablePolicyTemplate"
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
  name: 'TablePolicyTemplate',
  computed: {
    defaultPolicyTemplate () {
      return this.$store.state.tablePolicyTemplate
    }
  },
  methods: {
    save () {
      this.$store.commit('updateTablePolicyTemplate', {tablePolicyTemplate: this.tablePolicyTemplate})
    },
    load () {
      this.tablePolicyTemplate = this.defaultPolicyTemplate
    }
  },
  data () {
    return {
      tablePolicyTemplate: null
    }
  },
  mounted () {
    this.load()
  }
}
</script>

