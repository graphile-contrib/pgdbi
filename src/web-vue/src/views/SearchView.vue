<template>
  <v-container
    ma-0 
    pa-0
  >
    <function-search></function-search>
  </v-container>
</template>

<script>
  import FunctionSearch from '@/components/Function/FunctionSearch'

  export default {
    name: 'SearchView',
    components: {
      FunctionSearch
    },
    props: {
    },
    computed: {
    },
    watch: {
    },
    data: () => ({
      searchTerm: '',
    }),
    methods: {
    },
  }
</script>

<style>

</style>
