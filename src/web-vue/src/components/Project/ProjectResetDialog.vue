
<template>
    <div>
      <v-dialog v-model="dialog" persistent width="800">
        <template v-slot:activator="{ on }">
          <v-btn 
            dark v-on="on"
            class="text-none"
          >
            Reset PGDBI
          </v-btn>
        </template>
        <v-card>
          <v-card-text>Are you sure you want to reset PGDBI?</v-card-text>
          <v-card-text>This will discard all policy definitions and assignement</v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn @click="dialog=false">Cancel</v-btn>
            <v-btn @click="resetPgdbi">Turn your key sir!</v-btn>
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
    },
    watch: {
    },
    methods: {
      resetPgdbi () {

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