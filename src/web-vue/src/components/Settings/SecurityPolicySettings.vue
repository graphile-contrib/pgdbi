<template>
  <v-container>
    <v-toolbar>
      <v-btn @click="resetState">Reset</v-btn>
      <v-btn @click="saveState">Save</v-btn>
    </v-toolbar>
    <hr>
    <v-card>
      <v-text-field
        label="App Tenant Field Name"
        v-model="appTenantFieldName"
      ></v-text-field>
    </v-card>
    <v-tabs
      dark
      slider-color="yellow"
    >
      <v-tab
        key="default-policy-without-rls"
        ripple
      >
        Without Rls
      </v-tab>
      <v-tab-item
        key="default-policy-without-rls"
      >
        <v-textarea
          v-model="policyTemplateNoRls"
          auto-grow
          spellcheck="false"
          :min-height="800"
        ></v-textarea>
      </v-tab-item>

      <v-tab
        key="default-policy-with-rls"
        ripple
      >
        With Rls
      </v-tab>
      <v-tab-item
        key="default-policy-with-rls"
      >
        <v-textarea
          v-model="policyTemplateRls"
          auto-grow
          spellcheck="false"
        ></v-textarea>
      </v-tab-item>

    </v-tabs>

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
      this.$store.commit('policyTemplateNoRls', { policyTemplateNoRls: this.policyTemplateNoRls })
      this.$store.commit('policyTemplateRls', { policyTemplateRls: this.policyTemplateRls })
      this.$store.commit('appTenantFieldName', { appTenantFieldName: this.appTenantFieldName })
    },
    resetState () {
      this.$store.commit('resetDefaultState')
      this.loadState()
    },
    loadState () {
      this.policyTemplateNoRls = this.$store.state.policyTemplateNoRls
      this.policyTemplateRls = this.$store.state.policyTemplateRls
      this.appTenantFieldName = this.$store.state.appTenantFieldName
    }
  },
  data () {
    return {
      policyTemplateNoRls: '',
      policyTemplateRls: '',
      appTenantFieldName: ''
    }
  },
  mounted () {
    this.loadState()
  }
}
</script>

