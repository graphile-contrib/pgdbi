<template>
  <v-container>
    <v-tabs>
      <v-tab key="schemata">Schemata</v-tab>
      <v-tab-item key="schemata">
        <v-toolbar>
          <v-btn @click="toggleFilter" :hidden="!filterActive" :disabled="applyDisabled">Apply</v-btn>
          <v-btn @click="toggleFilter" :hidden="filterActive">Filter</v-btn>
        </v-toolbar>    
        <schema-tree v-if="!filterOn"></schema-tree>
        <schema-filter v-if="filterOn" @click="toggleFilter" ref="schemaFilter" :selectionChanged="selectionChanged"></schema-filter>
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
      filterOn () {
        return this.filterActive || this.initializing
      },
      initializing () {
        const retval = this.$store.state.initializing
        return retval
      },
    },
    watch: {
    },
    methods: {
      selectionChanged (selected) {
        this.applyDisabled = selected.length === 0
      },
      toggleFilter () {
        if (this.toggleComplete === true) {
          this.toggleComplete = false
        } else {
          if (this.filterActive) {
            this.filterActive = false
            this.$refs.schemaFilter.apply()
          } else {
            this.filterActive = true
          }
          this.toggleComplete = true
        }
      }
    }
  }
</script>

<style>

</style>
