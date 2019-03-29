<template>
  <v-container>
    <v-tabs>
      <v-tab key="schemata">Schemata</v-tab>
      <v-tab-item key="schemata">
        <v-toolbar>
          <v-btn @click="applyFilter" :hidden="!schemaFilterOn" :disabled="applyDisabled">Apply</v-btn>
          <v-btn @click="filterSchemata" :hidden="schemaFilterOn">Filter</v-btn>
        </v-toolbar>    
        <schema-tree v-if="!schemaFilterOn"></schema-tree>
        <schema-filter v-if="schemaFilterOn" ref="schemaFilter" :selectionChanged="selectionChanged"></schema-filter>
      </v-tab-item>
    </v-tabs>    
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
      filterActive: () => {
        return this.initializing
      },
      toggleComplete: false,
      applyDisabled: false
    }),
    computed: {
      initializing () {
        return this.$store.state.initializing
      },
      schemaFilterOn () {
        return this.$store.state.schemaFilterOn
      }
    },
    watch: {
    },
    methods: {
      selectionChanged (selected) {
        this.applyDisabled = selected.length === 0
      },
      applyFilter () {
        this.$refs.schemaFilter.apply()
      },
      filterSchemata () {
        this.$store.commit('filterSchemata')
      }
    }
  }
</script>

<style>

</style>
