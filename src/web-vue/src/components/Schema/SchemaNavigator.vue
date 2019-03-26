<template>
  <v-container>
    <v-tabs>
      <v-tab key="schemata">Schemata</v-tab>
      <v-tab-item key="schemata">
        <v-toolbar>
          <v-btn @click="toggleFilter">{{filterButtonText}}</v-btn>
        </v-toolbar>    
        <schema-tree v-if="!filterOn"></schema-tree>
        <schema-filter v-if="filterOn" :afterApply="toggleFilter"></schema-filter>
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
      filterOn: false,
      forceRefetch: false
    }),
    computed: {
      filterButtonText () {
        return this.filterOn ? 'Apply' : 'Filter'
      },
    },
    methods: {
      toggleFilter () {
        this.filterOn = !this.filterOn
      }
    }
  }
</script>

<style>

</style>
