<template>
  <v-container>
    <v-row>
      <v-col cols="10"></v-col>
      <v-col><a href="https://pglint.com">https://pglint.com</a></v-col>
    </v-row>
    <v-row>
      <v-col cols="3">
        <v-text-field 
          label="token"
          v-model="token"
          placeholder="enter your pglint token"
        ></v-text-field>
      </v-col>
      <v-col cols="2"></v-col>
      <v-col cols="3">
        <v-text-field 
          label="project"
          v-model="project"
          placeholder="enter your pglint project"
        ></v-text-field>
      </v-col>
      <v-col cols="2"></v-col>
      <v-col cols="2">
        <v-btn @click="doPgLint" :disabled="pgLintDisabled" class="grey">SUBMIT TO PGLINT</v-btn>
      </v-col>
    </v-row>
    <v-data-table
      :headers="headers"
      :items="pgLintResults"
      hide-default-footer
      disable-sort
    >
      <template v-slot:item.url="{ item }">
        <a :href="item.url" target="_blank">{{item.url}}</a>
      </template>
    </v-data-table>
  </v-container>
</template>

<script>
import pgLint from '@/gql/mutation/pgLint.graphql'
import pglintrc from '@/gql/query/pglintrc.graphql'

export default {
  name: 'PgLintView',
  components: {
  },
  data () {
    return {
      token: null,
      project: null,
      headers: [
        {
          text: "id",
          value: "id"
        },
        {
          text: "status",
          value: "status"
        },
        {
          text: "checks",
          value: "checks"
        },
        {
          text: "errors",
          value: "errors"
        },
        {
          text: "warnings",
          value: "warnings"
        },
        {
          text: "url",
          value: "url"
        },
      ]
    }
  },
  computed: {
    pgLintResults () {
      return this.$store.state.pgLintResults
        .sort((a,b)=>{
          return b.id - a.id
        })
    },
    pgLintDisabled () {
      return this.token === null || this.project === null
    }
  },
  methods: {
    doPgLint () {
      this.$loading(true)
      this.$apollo.mutate({
        mutation: pgLint,
        variables: {
          token: this.token,
          project: this.project
        }
      })
      .then(result => {
        this.$loading(false)
        this.$store.commit('savePgLintResult', result.data.PgLint.result)
      })
      .catch(e => {
        this.$loading(false)
        alert('ERROR')
        console.error(e)
      })
    }
  },
  apollo: {
    init: {
      query: pglintrc,
      networkPolicy: 'fetch-only',
      update (data) {
        this.token = data.pglintrc.pglintrc.token
        this.project = data.pglintrc.pglintrc.project
      }
    }
  }

}
</script>

<style>

</style>