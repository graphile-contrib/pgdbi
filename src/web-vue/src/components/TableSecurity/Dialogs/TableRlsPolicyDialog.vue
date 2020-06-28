
<template>
    <v-container>
      <v-dialog v-model="dialog" persistent width="1400">
        <template v-slot:activator="{ on }">
          <v-btn
            small
            
            v-on="on"
            :disabled="btnDisabled"
            :hidden="hidden"
            class="green darken-2"
            @click="activate"
          >
            <v-icon>mdi-plus</v-icon>
          </v-btn>
        </template>
        <v-card>
          <v-card-title class="headline">Rls Policy</v-card-title>
          <v-container>
            <v-row>
              <v-col cols="3">
                <v-text-field label="Name" v-model="currentName" :disabled="disabled"></v-text-field>
              </v-col>
              <v-col cols="6">
                <v-text-field label="Using" v-model="currentUsing" :disabled="disabled"></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="3">
                <v-radio-group v-model="currentPassStrategy" :column="false" :disabled="disabled">
                  <v-radio
                    label="Permissive"
                    value="permissive"
                  ></v-radio>
                  <v-radio
                    label="Restrictive"
                    value="restrictive"
                  ></v-radio>
                </v-radio-group>
              </v-col>
              <v-col cols="6">
                <v-text-field label="With Check" v-model="currentWithCheck" :disabled="disabled"></v-text-field>
              </v-col>
            </v-row>
          </v-container>
          <v-card-actions>
            <v-spacer></v-spacer>
            <!-- <v-btn :hidden="disabled" @click="updateRlsPolicy(roleName, action, rlsPolicy.id, currentUsing, currentWithCheck, currentPassStrategy, currentName); dialog=false">Update</v-btn>
            <v-btn :hidden="disabled" @click="disableRlsPolicy(roleName, action, rlsPolicy.id); dialog=false">Disable</v-btn> -->
            <v-btn :hidden="disabled" @click="dialog=false">Cancel</v-btn>
            <v-btn :hidden="!disabled" @click="dialog=false">OK</v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-container>
</template>

<script>
  const ENABLED = 'ENABLED'
  const DISABLED = 'DISABLED'
  const IMPLIED = 'IMPLIED'

  export default {
    name: 'TableRlsPolicyDialog',
    props: {
      disabled: {
        type: Boolean,
        default: false
      },
      status: {
        type: String,
        required: false
      },
      rlsPolicy: {
        type: Object,
        required: false,
        default () {
          return {}
        }
      },
      action: {
        type: String,
        required: false
      },
      roleName: {
        type: String,
        required: false
      },
      disableRlsPolicy: {
        type: Function,
        required: false
      },
      updateRlsPolicy: {
        type: Function,
        required: false
      }
    },
    data () {
      return {
        toggleCompleted: false,
        dialog: false,
        dialog2: false,
        currentName: 'n/a',
        currentUsing: 'n/a',
        currentWithCheck: 'n/a',
        currentPassStrategy: false
      }
    },
    computed: {
      // displayValue () {
      //   return this.rlsPolicy.name //.slice(0,20).concat('...')
      //   // return this.rlsPolicy.using.slice(0,20).concat('...')
      // },
      rlsQualifierDisplayValueDisabled () {
        return false
      },
      hidden () {
        return false
      },
      btnDisabled () {
        return false
        // return ([DISABLED, IMPLIED].indexOf(this.status) > -1) // || this.disabled
        // return [DISABLED, IMPLIED].indexOf(this.rlsPolicy.status) > -1
      }
    },
    watch: {
    },
    methods: {
      activate () {
        this.currentName = this.rlsPolicy.name
        this.currentUsing = this.rlsPolicy.using
        this.currentWithCheck = this.rlsPolicy.withCheck
        this.currentPassStrategy = this.rlsPolicy.passStrategy
      }
    }
  }
</script>

<style>
.norm-text {
  text-transform: none !important;
}
</style>