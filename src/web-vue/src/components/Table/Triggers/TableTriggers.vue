<template>
  <v-container>
    <table-trigger-set
      actionTiming="BEFORE"
      eventManipulation="INSERT"
      :triggers="beforeInsert"
    ></table-trigger-set>

    <table-trigger-set
      actionTiming="BEFORE"
      eventManipulation="UPDATE"
      :triggers="beforeUpdate"
    ></table-trigger-set>

    <table-trigger-set
      actionTiming="BEFORE"
      eventManipulation="DELETE"
      :triggers="beforeDelete"
    ></table-trigger-set>

    <table-trigger-set
      actionTiming="AFTER"
      eventManipulation="INSERT"
      :triggers="afterInsert"
    ></table-trigger-set>

    <table-trigger-set
      actionTiming="AFTER"
      eventManipulation="UPDATE"
      :triggers="afterInsert"
    ></table-trigger-set>

    <table-trigger-set
      actionTiming="AFTER"
      eventManipulation="DELETE"
      :triggers="afterDelete"
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
