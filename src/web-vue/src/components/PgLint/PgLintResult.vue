<template>
  <v-card>
    {{pgLintResult.url}}
  </v-card>  
</template>

<script>
export default {
  name: 'PgLintResult',
  data () {
    return {

    }
  },
  props: {
    pgLintResult: {
      type: Object,
      required: true
    }
  }
}
</script>

<style>

</style>