
<template>
    <div>
      <v-dialog v-model="dialog" persistent>
        <template v-slot:activator="{ on }">
          <v-btn 
            dark v-on="on"
            :disabled="rlsQualifierDisplayValueDisabled"
            :hidden="rlsQualifierDisplayValueDisabled"
            class="text-none"
            @click="activate"
          >
            {{ displayValue }}
          </v-btn>
        </template>
        <v-card>
          <v-card-title class="headline">Rls Policy</v-card-title>
          <v-text-field label="Using" v-model="currentUsing"></v-text-field>
          <v-text-field label="With Check" v-model="currentWithCheck"></v-text-field>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="green darken-1" flat @click="updateRlsPolicy(roleName, action, currentUsing, currentWithCheck); dialog=false">Update</v-btn>
            <v-btn color="green darken-1" flat @click="disableRlsPolicy(roleName, action); dialog=false">Disable</v-btn>
            <v-btn color="green darken-1" flat @click="dialog=false">Cancel</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
</template>

<script>
  const ENABLED = 'ENABLED'
  const DISABLED = 'DISABLED'
  const IMPLIED = 'IMPLIED'

  export default {
    name: 'RlsPolicyDialog',
    props: {
      rlsPolicy: {
        type: Object,
        required: true
      },
      action: {
        type: String,
        required: true
      },
      roleName: {
        type: String,
        required: true
      },
      disableRlsPolicy: {
        type: Function,
        required: true
      },
      updateRlsPolicy: {
        type: Function,
        required: true
      }
    },
    data () {
      return {
        toggleCompleted: false,
        dialog: false,
        currentUsing: 'n/a',
        currentWithCheck: 'n/a',
      }
    },
    computed: {
      displayValue () {
        switch (this.rlsPolicy.status) {
          case ENABLED:
            return this.rlsPolicy.using.slice(0,20).concat('...')
            break;
          case IMPLIED:
            return IMPLIED
            break;
          case DISABLED:
            return DISABLED          
            break;
        }
      },
      rlsQualifierDisplayValueDisabled () {
        return [DISABLED, IMPLIED].indexOf(this.rlsPolicy.status) > -1
      }
    },
    watch: {
    },
    methods: {
      activate () {
        console.log('activate')
        this.currentUsing = this.rlsPolicy.using
        this.currentWithCheck = this.rlsPolicy.withCheck
      }
    }
  }
</script>

<style>
.norm-text {
  text-transform: none !important;
}
</style>