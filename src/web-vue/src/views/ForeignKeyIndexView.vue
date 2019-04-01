<template>
  <v-container
    ma-0 
    pa-0
  >
    <v-tabs
      v-model="activeTab"
      dark
    >
      <v-tab
        key="policy-manager"
        ripple
      >
        Policy Templates
      </v-tab>
      <v-tab-item
        key="policy-manager"
      >
        <v-card>
          <policy-manager></policy-manager>
        </v-card>
      </v-tab-item>

    </v-tabs>
  </v-container>
</template>

<script>
  import PolicyManager from '@/components/ForeignKeyIndex/ForeignKeyIndexManager'

  export default {
    name: 'ForeignKeyIndexView',
    components: {
      PolicyManager,
    },
    props: {
    },
    computed: {
    },
    data: () => ({
      activeTab: null
    }),
    apollo: {
    }
  }
</script>

<style>

</style>
