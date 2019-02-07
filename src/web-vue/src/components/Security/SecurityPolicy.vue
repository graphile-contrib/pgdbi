<template>
  <v-card>
    SECURITY POLICY
    <v-textarea
      :value="JSON.stringify(displayData,0,2)"
      auto-grow
    ></v-textarea>
    <!-- {{ appRoles }} -->
    <v-textarea
      :value="JSON.stringify(tableItem,0,2)"
      auto-grow
    ></v-textarea>
  </v-card>
</template>

<script>
  export default {
    name: 'SecurityPolicy',
    components: {
    },
    props: {
      appRoles: {
        type: Array,
        required: true
      },
      tableItem: {
        type: Object,
        required: true
      }
    },
    computed: {
      displayData () {
        return this.appRoles.map(
          role => {
            return {
              role: role
            }
          }
        )
      }
    },
    data: () => ({
    })
  }
</script>

<style>

</style>
