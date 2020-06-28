<template>
    <v-container ma-0 pa-0 :class="myClass">
      <v-toolbar>
        <v-row class="blue-grey darken-4">
          <v-col cols="2">
            <h3>{{table.tableSchema}}.{{table.tableName}}</h3>
          </v-col>
          <!-- <v-col>
            <v-checkbox
              v-model="enableRls"
              label="Enable RLS"
            ></v-checkbox>
          </v-col> -->
          <v-col>
            <h3 class="green--text" v-if="table.rlsEnabled">RLS Currently Enabled</h3>
            <h3 class="red--text" v-else>RLS Currently Disabled</h3>
          </v-col>
          <v-col>
            <h3>{{policyDefinition.name}}</h3>
          </v-col>
        </v-row>
      </v-toolbar>
      <v-checkbox
        v-model="enableRls"
        label="Enable RLS"
      ></v-checkbox>
      <v-row v-if="policies.length > 0">
        <v-col cols="6">
          <v-data-table
            :items="policies"
            :headers="headers"
            hide-default-footer
            dense
          >
            <template v-slot:header.actions>
              <v-btn class="green darken-2" small>
                <v-icon>mdi-plus</v-icon>
              </v-btn>
            </template>

            <template v-slot:item.actions="{ item }">
              <v-btn small @click="editRlsPolicy(item)"><v-icon>mdi-pencil</v-icon></v-btn>
              <v-btn small @click="deleteRlsPolicy(item)"><v-icon>mdi-delete</v-icon></v-btn>
            </template>
          </v-data-table>
        </v-col>
        <v-col cols="6">
          <table-grant-grid 
            :policyDefinition="policyDefinition">
          </table-grant-grid>
        </v-col>
      </v-row>
      <v-row v-else>
        <v-col cols="6">
          <v-row>
            <v-col cols=2>
              <v-container ma-0 px-4 py-0>
                <v-btn class="green darken-2" small>
                  <v-icon>mdi-plus</v-icon>
                </v-btn>
              </v-container>
            </v-col>
            <v-col class="red--text font-weight-bold">NO RLS POLICIES DEFINED</v-col>
            <v-col cols=2></v-col>
          </v-row>
        </v-col>
      </v-row>
    </v-container>
</template>

<script>
  import TableGrantGrid from "./TableGrantGrid"

  export default {
    name: 'TableSecurityProfileManager',
    components: {
      TableGrantGrid
    },
    props: {
      table: {
        type: Object,
        required: true
      },
      index: {
        type: Number,
        required: true
      }
    },
    methods: {
      editRlsPolicy(item) {
        console.log(item)
      },
      deleteRlsPolicy(item) {
        console.log(item)
      },
      saveNewPolicy () {
        try {
          this.$store.commit('newPolicy', {name: this.newPolicyName})
        }
        catch (e) {
          alert(e.toString())
          console.error(e)
        }
        this.dialog = false
      }
    },
    computed: {
      myClass () {
        return this.index % 2 === 0 ? 'blue-grey darken-4' : 'blue-grey darken-2'

      },
      policies () {
        return this.table.policies.sort(function(a,b) {return a.id < b.id ? -1 : 1})
        .map(p => {
          return {
            ...p,
            edit: true
          }
        })
      },
      policyDefinition () {
        const tableId = `${this.table.tableSchema}.${this.table.tableName}`
        const policies = this.$store.state.policies
        const policyId = this.$store.state.tablePolicyAssignments[tableId].policyDefinitionId
        const pol = this.$store.state.policies.find(p => p.id === policyId)
        console.log('pol', pol)
        return pol
      },
    },
    data () {
      return {
        enableRls: true,
        dialog: false,
        newPolicyName: 'New Table Policy',
        headers: [
          {
            value: 'actions'
          },
          {
            text: 'cmd',
            sortable: false,
            value: 'cmd'
          },
          {
            text: 'policy name',
            sortable: false,
            value: 'policyname'
          },
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