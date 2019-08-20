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
        hide-default-footer
        item-key="id"
        class="text-sm-left"
      >
        <template slot="items" slot-scope="props">
          <tr @click="props.expanded = !props.expanded">
            <td key="id">{{ props.item.id }}</td>
            <td key="name">{{ props.item.name }}</td>
          </tr>
        </template>

        <template slot="expand" slot-scope="props">
          <policy-definition
            :key="props.item.id"
            :policyId="props.item.id"
          ></policy-definition>
        </template>
      </v-data-table>
    </div>
</template>

<script>
  import PolicyDefinition from '@/components/FunctionSecurity//Definition/FunctionPolicyDefinition.vue'

  export default {
    name: 'FunctionPolicyManager',
    components: {
      PolicyDefinition
    },
    methods: {
      saveNewPolicy () {
        try {
          this.$store.commit('newFunctionPolicy', {name: this.newPolicyName})
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
        return this.$store.state.functionPolicies.sort(function(a,b) {return a.id < b.id ? -1 : 1})
      }
    },
    data () {
      return {
        dialog: false,
        newPolicyName: 'New Function Policy',
        headers: [
          {
            text: 'ID',
            sortable: false
          },
          {
            text: 'Name',
            sortable: false
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