<template>
  <v-container
    ma-0 
    pa-0
  >
    <constraints-and-indices-manager></constraints-and-indices-manager>
  </v-container>
</template>

<script>
  import ConstraintsAndIndicesManager from '@/components/ForeignKeyIndex/ConstraintsAndIndicesManager'

  export default {
    name: 'ForeignKeyIndexView',
    components: {
      ConstraintsAndIndicesManager,
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
