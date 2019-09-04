<template>
  <v-container>
    <table-trigger-set
      actionTiming="BEFORE"
      eventManipulation="INSERT"
      :triggers="beforeInsert"
      class="pa-1 ma-1 green"
    ></table-trigger-set>

    <table-trigger-set
      actionTiming="BEFORE"
      eventManipulation="UPDATE"
      :triggers="beforeUpdate"
      class="pa-1 ma-1 green darken-2"
    ></table-trigger-set>

    <table-trigger-set
      actionTiming="BEFORE"
      eventManipulation="DELETE"
      :triggers="beforeDelete"
      class="pa-1 ma-1 green darken-4"
    ></table-trigger-set>

    <table-trigger-set
      actionTiming="AFTER"
      eventManipulation="INSERT"
      :triggers="afterInsert"
      class="pa-1 ma-1 blue"
    ></table-trigger-set>

    <table-trigger-set
      actionTiming="AFTER"
      eventManipulation="UPDATE"
      :triggers="afterUpdate"
      class="pa-1 ma-1 blue darken-2"
    ></table-trigger-set>

    <table-trigger-set
      actionTiming="AFTER"
      eventManipulation="DELETE"
      :triggers="afterDelete"
      class="pa-1 ma-1 blue darken-4"
    ></table-trigger-set>
  </v-container>
</template>

<script>
import TableTriggerSet from './TableTriggerSet'

export default {
    name: 'TableTriggers',
    props: {
      triggers: {
        type: Array,
        required: true
      }
    },
    components: {
      TableTriggerSet
    },
    computed: {
      beforeInsert () {
        return this.triggers.filter(t => t.actionTiming === 'BEFORE' && t.eventManipulation === 'INSERT')
      },
      beforeUpdate () {
        return this.triggers.filter(t => t.actionTiming === 'BEFORE' && t.eventManipulation === 'UPDATE')
      },
      beforeDelete () {
        return this.triggers.filter(t => t.actionTiming === 'BEFORE' && t.eventManipulation === 'DELETE')
      },
      afterInsert () {
        return this.triggers.filter(t => t.actionTiming === 'AFTER' && t.eventManipulation === 'INSERT')
      },
      afterUpdate () {
        return this.triggers.filter(t => t.actionTiming === 'AFTER' && t.eventManipulation === 'UPDATE')
      },
      afterDelete () {
        return this.triggers.filter(t => t.actionTiming === 'AFTER' && t.eventManipulation === 'DELETE')
      },
    }
  }
</script>

<style>

</style>
