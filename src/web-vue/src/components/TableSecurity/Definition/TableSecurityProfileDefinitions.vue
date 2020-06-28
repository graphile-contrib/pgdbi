<template>
    <div>
      <v-toolbar>
        <v-dialog v-model="dialog" persistent max-width="290">
          <template v-slot:activator="{ on }">
            <v-btn color="primary" dark v-on="on">New Policy Template</v-btn>
          </template>
          <v-card>
            <v-card-title class="headline">New Policy</v-card-title>
            <v-text-field label="Name" v-model="newPolicyName"></v-text-field>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="green darken-1" flat @click="saveNewPolicy">Save</v-btn>
              <v-btn color="green darken-1" flat @click="dialog = false">Cancel</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-toolbar>
      <v-data-table
        :headers="headers"
        :items="policies"
        item-key="id"
        dense
        disable-pagination
        disable-sort
        hide-default-footer
        show-expand
      >
        <template v-slot:item.name="{ item }">
          <router-link :to="{ name: 'table-security-profile-definition', params: { policyDefinitionId: item.id }}" target="_blank">{{item.name}}</router-link>
        </template>
        <!-- <template slot="expanded-item" slot-scope="props">
          <td :colspan="headers.length + 1">
            <policy-definition
              :key="props.item.id"
              :policyId="props.item.id"
            ></policy-definition>
          </td>
        </template> -->

      </v-data-table>
    </div>
</template>

<script>
  import PolicyDefinition from '@/components/TableSecurity/Definition/TablePolicyDefinition.vue'

  export default {
    name: 'PolicyManager',
    components: {
      PolicyDefinition
    },
    methods: {
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
      policies () {
        return this.$store.state.policies.sort(function(a,b) {return a.id < b.id ? -1 : 1})
      }
    },
    data () {
      return {
        dialog: false,
        newPolicyName: 'New Table Policy',
        headers: [
          {
            text: ''
          },
          {
            text: 'ID',
            sortable: false,
            value: 'id'
          },
          {
            text: 'Name',
            sortable: false,
            value: 'name'
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