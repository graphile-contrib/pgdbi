<template>
  <v-container
    ma-0 
    pa-0
  >
    <schema-tree></schema-tree>
  </v-container>
</template>

<script>
  import SchemaTree from '@/components/Schema/SchemaTree'

  export default {
    name: 'SchemaNavigator',
    components: {
      SchemaTree,
    },
    data: () => ({
    }),
    computed: {
    },
    watch: {
    },
    methods: {
    }
  }
</script>

<style>

</style>
