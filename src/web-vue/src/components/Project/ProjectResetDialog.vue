
<template>
    <div>
      <v-dialog v-model="dialog" persistent width="800">
        <template v-slot:activator="{ on }">
          <v-btn 
            dark v-on="on"
            class="text-none"
          >
            RESET PGDBI
          </v-btn>
        </template>
        <v-card>
          <v-card-text>Are you sure you want to reset PGDBI?</v-card-text>
          <v-card-text>This will discard all policy definitions and assignement</v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn @click="dialog=false">Cancel</v-btn>
            <v-btn @click="saveFirst" :hidden="saveFirstHidden" class="red">Save Project First</v-btn>
            <v-btn @click="resetPgdbi">Exterminate!</v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
</template>

<script>
  export default {
    name: 'ProjectResetDialog',
    props: {
    },
    mounted () {
    },
    data () {
      return {
        dialog: false
      }
    },
    computed: {
      saveFirstHidden () {
        return !this.$store.state.isDirty
      }
    },
    watch: {
    },
    methods: {
      resetPgdbi () {
        this.$store.dispatch('resetDefaultState')
        .then(()=>{
          this.$router.push('initialize').catch(err => {})
          this.dialog = false
        })
      },
      saveFirst () {
        this.$store.dispatch('writeToDisk')
        .then(result => {
          this.resetPgdbi()
        })
        .catch(e => {
          alert('ERROR')
          console.error(e)
        })
      }
    },
    mounted () {
    }
  }
</script>

<style>
.norm-text {
  text-transform: none !important;
}
</style>