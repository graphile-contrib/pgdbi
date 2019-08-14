<template>
  <v-data-table
    :headers="headers"
    :items="functions"
    hide-actions
  >
    <template slot="items" slot-scope="props">
      <td @click="props.expanded = !props.expanded">
        <v-btn icon @click.stop="props.expanded = !props.expanded">
          <v-icon>{{ props.expanded ? 'expand_less' : 'expand_more' }}</v-icon>
        </v-btn>
        {{ props.item.name }}
      </td>
      <td>{{props.item.functionSchema}}</td>
      <td>{{props.item.functionName}}</td>
      <td><router-link :to="{ name: 'function', params: { id: props.item.id }}" target="_blank"><v-icon>launch</v-icon></router-link></td>
    </template>

    <template slot="expand" slot-scope="props">
      <function :id="props.item.id">
      </function>
    </template>
  </v-data-table>
</template>

<script>
  import Function from './Function'

  export default {
    name: 'FunctionList',
    components: {
      Function
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
          text: ''
          ,sortable: false
        },
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
