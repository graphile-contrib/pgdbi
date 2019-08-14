<template>
  <v-container
    ma-0 
    pa-0
  >
    <h1>Foreign Key Index Manager</h1>
    <h2>A tool to ensure that all <a href="https://www.graphile.org/postgraphile/postgresql-indexes/" target="_blank">foreign keys</a> are properly indexed to support postgraphile</h2>
    <h1 style="color: red;">Under Construction</h1>
    <hr>
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
    })
  }
</script>

<style>

</style>
