<template>
  <v-container>
    <v-text-field 
      label="token"
      v-model="token"
      placeholder="enter your pglint token"
    ></v-text-field>
    <v-text-field 
      label="project"
      v-model="project"
      placeholder="enter your pglint project"
    ></v-text-field>
    <v-btn @click="doPgLint" :disabled="pgLintDisabled">pg-lint!</v-btn>
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
      this.$apollo.mutate({
        mutation: pgLint,
        variables: {
          token: this.token,
          project: this.project
        }
      })
      .then(result => {
        this.$store.commit('savePgLintResult', result.data.PgLint.result)
      })
      .catch(e => {
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