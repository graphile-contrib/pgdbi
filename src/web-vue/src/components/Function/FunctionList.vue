<template>
  <v-data-table
    :headers="headers"
    :items="functions"
    hide-actions
  >
    <template slot="items" slot-scope="props">
      <td>{{props.item.functionSchema}}</td>
      <td>{{props.item.functionName}}</td>
      <td><router-link :to="{ name: 'function', params: { id: props.item.id }}" target="_blank"><v-icon>launch</v-icon></router-link></td>
    </template>
  </v-data-table>
</template>

<script>
  export default {
    name: 'FunctionList',
    components: {
    },
    props: {
      functions: {
        type: Array,
        required: true
      }
    },
    computed: {
    },
    data: () => ({
      headers: [
        {
          text: 'schema'
          ,sortable: false
        },
        {
          text: 'function'
          ,sortable: false
        },
        {
          text: ''
          ,sortable: false
        }
      ]
    }),
    methods: {
    },
  }
</script>

<style>

</style>
