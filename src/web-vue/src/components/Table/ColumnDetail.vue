<template>
  <v-card>
    <v-card-title>{{columnInfo.columnName}}</v-card-title> 
  </v-card>
</template>

<script>
export default {
  name: 'ColumnDetail',
  props: {
    columnInfo: {
      type: Object,
      required: true
    }
  }
}
</script>