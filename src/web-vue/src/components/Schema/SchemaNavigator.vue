<template>
  <v-container>
    <v-tabs>
      <v-tab key="schemata">Schemata</v-tab>
      <v-tab-item key="schemata">
        <v-toolbar>
          <v-btn @click="toggleFilter">{{filterButtonText}}</v-btn>
        </v-toolbar>    
        <schema-tree v-if="!filterOn"></schema-tree>
        <schema-filter v-if="filterOn" @click="toggleFilter" ref="schemaFilter"></schema-filter>
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
      filterSelection: false,
      forceRefetch: false
    }),
    computed: {
      forceFilterOn () {
        return this.$store.state.managedSchemata.length === 0
      },
      filterButtonText () {
        return this.filterOn ? 'Apply' : 'Filter'
      },
      filterOn () {
        return this.filterSelection || this.forceFilterOn
      }
    },
    methods: {
      toggleFilter () {
        if (this.filterSelection) {
          this.$refs.schemaFilter.apply()
        }

        this.filterSelection = !this.filterSelection
      }
    }
  }
</script>

<style>

</style>
