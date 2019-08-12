<template>
  <v-container
    ma-0 
    pa-0
  >
    <schema-tree v-if="!schemaFilterOn"></schema-tree>
    <schema-filter v-if="schemaFilterOn"></schema-filter>
  </v-container>
</template>

<script>
  import SchemaTree from '@/components/Schema/SchemaTree'
  import SchemaFilter from '@/components/Schema/SchemaFilter'

  export default {
    name: 'SchemaNavigator',
    components: {
      SchemaTree,
      SchemaFilter
    },
    data: () => ({
    }),
    computed: {
      schemaFilterOn () {
        return false
        return this.$store.state.schemaFilterOn
      }
    },
    watch: {
    },
    methods: {
    }
  }
</script>

<style>

</style>
