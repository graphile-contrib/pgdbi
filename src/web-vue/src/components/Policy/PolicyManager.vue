<template>
    <div>
      <v-toolbar>
        <v-dialog v-model="dialog" persistent max-width="290">
          <template v-slot:activator="{ on }">
            <v-btn color="primary" dark v-on="on">New Policy</v-btn>
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
        hide-actions
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
            policyName="Default Policy"
            :policyId="props.item.id"
          ></policy-definition>
        </template>
      </v-data-table>
    </div>
</template>

<script>
  import PolicyDefinition from './PolicyDefinition.vue'

  export default {
    name: 'PolicyManager',
    components: {
      PolicyDefinition
    },
    methods: {
      saveNewPolicy () {
        this.$store.commit('newPolicy', {name: this.newPolicyName})
        this.dialog = false
      }
    },
    computed: {
      policies () {
        console.log('policies', this.$store.state.policies)
        return this.$store.state.policies

      }
    },
    data () {
      return {
        dialog: false,
        newPolicyName: 'New Policy',
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
    }
  }
</script>