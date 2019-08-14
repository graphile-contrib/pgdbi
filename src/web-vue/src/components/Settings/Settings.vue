<template>
  <v-container>
    <h1>Settings</h1>
    <h2 style="color: red;">Under Construction</h2>
    <hr>
    <v-tabs
      v-model="activeTab"
      dark
    >
      <v-tab
        key="table-policy-template"
        ripple
      >
        Table Policy Template
      </v-tab>
      <v-tab-item
        key="table-policy-template"
      >
      <security-policy-settings></security-policy-settings>
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>

<script>
  import SecurityPolicySettings from '@/components/Settings/SecurityPolicySettings'

  export default {
    name: 'Settings',
    components: {
      SecurityPolicySettings
    },
    props: {
    },
    computed: {
    },
    data: () => ({
      activeTab: null
    })
  }
</script>

<style>

</style>
