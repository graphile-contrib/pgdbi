<template>
  <v-container>
    <v-toolbar>
      <v-btn @click="resetState">Reset</v-btn>
      <v-btn @click="saveState">Save</v-btn>
    </v-toolbar>
    <hr>
  </v-container>
</template>

<script>
export default {
  name: 'SecurityPolicySettings',
  computed: {
    // policyTemplateNoRls () {
    //   return this.$store.state.policyTemplateNoRls
    // },
    // policyTemplateRls () {
    //   return this.$store.state.policyTemplateRls
    // },
    // appTenantFieldName () {
    //   return this.$store.state.appTenantFieldName
    // }
  },
  methods: {
    saveState () {
    },
    resetState () {
      this.$store.commit('resetDefaultState')
      this.loadState()
    },
    loadState () {
    }
  },
  data () {
    return {
    }
  },
  mounted () {
    this.loadState()
  }
}
</script>

