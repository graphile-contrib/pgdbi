<template>
  <v-container ma-0 pa-0>
    <table-security-profile v-for="(t,i) in tables" :key="t.tableName" :table="t" :index="i"></table-security-profile>
  </v-container>
</template>

<script>
  import TableSecurityProfile from './TableSecurityProfile.vue'

  export default {
    name: 'CurrentRlsPolicies',
    components: {
      TableSecurityProfile
    },
    methods: {
      edit(item) {
        console.log(item)

      },
    },
    computed: {
      tables () {
        return this.$store.state.managedSchemata.sort(function(a,b) {return a.id < b.id ? -1 : 1})
        .slice(0,1)
        .map(s => {
          return s.schemaTables 
          .slice(0,2)
        })
        .flat()

      },
      policies () {
        return this.$store.state.existingRlsPolicies.sort(function(a,b) {return a.id < b.id ? -1 : 1})
        .map(p => {
          return {
            ...p,
            edit: true
          }
        })
      }
    },
    data () {
      return {
        headers: [
          // {
          //   text: ''
          // },
          // {
          //   text: 'ID',
          //   sortable: false,
          //   value: 'id'
          // },
          {
            text: 'schema',
            sortable: false,
            value: 'tableSchema'
          },
          {
            text: 'table',
            sortable: false,
            value: 'tableName'
          },
          // {
          //   text: 'policy name',
          //   sortable: false,
          //   value: 'policyname'
          // },
          // {
          //   text: 'with clause',
          //   sortable: false,
          //   value: 'qual'
          // },
          {
            // text: 'edit',
            value: 'edit'
          }
        ]
      }
    },
    mounted() {
      if (process.client && window) {
        window.history.scrollRestoration = 'auto';
      }
    },
  }
</script>