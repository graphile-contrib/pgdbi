<template>
  <v-container>
   <v-toolbar v-if="showToolbar">
      <v-tooltip bottom>
        <template v-slot:activator="{ on }">
          <v-btn 
            v-on="on" 
            v-clipboard:copy="scriptText"
            v-clipboard:success="onCopy"
            v-clipboard:error="onError"
          ><v-icon>file_copy</v-icon>Copy
        </v-btn>
        </template>
        <span>Copy</span>
      </v-tooltip>
      <v-tooltip bottom>
        <template v-slot:activator="{ on }">
          <v-btn v-on="on" @click="executeSql" :disabled="!canExecute"><v-icon>arrow_forward</v-icon>Execute</v-btn>
        </template>
        <span>Execute</span>
      </v-tooltip>
      <v-spacer></v-spacer>
      <v-container fluid >
        <v-row>
          <v-spacer></v-spacer>
          <v-spacer></v-spacer>
          <v-layout v-if="showReadability">
            <label class="v-label theme--dark" mt-2>terse&nbsp;</label>
              <v-switch
              true-value="verbose"
              false-value="terse"
              v-model="readability"
              :label="`verbose`"
            ></v-switch>
          </v-layout>
          <v-layout v-if="showDeclarationVisibility">
            <label class="v-label theme--dark" mt-2>show declaration:&nbsp;</label>
              <v-switch
              true-value="hide"
              false-value="show"
              v-model="declarationVisibility"
              :label="`hide`"
            ></v-switch>
          </v-layout>
      </v-row>
      </v-container>
    </v-toolbar>
    <v-tabs
      v-model="activeTab"
      dark
    >
      <v-tab
        key="the-script"
        ripple
      >
        Script
      </v-tab>
      <v-tab-item
        key="the-script"
      >
        <v-textarea
          :disabled="!canEdit"
          :value="formatScript(scriptText)"
          auto-grow
          spellcheck="false"
          background-color="black"
        ></v-textarea>
      </v-tab-item>
      <v-tab
        key="exec-result"
        ripple
        v-if="results"
      >
        Execute Result
      </v-tab>
      <v-tab-item
        key="exec-result"
        v-if="results"
      >
        <v-textarea
          :disabled="!canEdit"
          :value="results"
          auto-grow
          spellcheck="false"
          background-color="black"
        ></v-textarea>
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>

<script>
  import execSql from '@/gql/mutation/execSql.graphql'

  export default {
    name: 'ScriptViewer',
    components: {
    },
    props: {
      scriptText: {
        type: String,
        required: false
      },
      showReadability: {
        type: Boolean,
        default: true
      },
      showDeclarationVisibility: {
        type: Boolean,
        default: false
      },
      showToolbar: {
        type: Boolean,
        default: true
      },
      skipFormat: {
        type: Boolean,
        default: false
      },
      canEdit: {
        type: Boolean,
        default: false
      },
      canExecute: {
        type: Boolean,
        default: false
      }
    },
    computed: {
    },
    watch: {
      readability () {
        this.$emit('readability-changed', this.readability)
      },
      declarationVisibility () {
        this.$emit('declaration-visibility-changed', this.declarationVisibility)
      }
    },
    methods: {
      formatScript (scriptText) {
        return this.skipFormat ? scriptText : (scriptText || '')
          .toLowerCase()
          .split(' exists').join(' exists\n  ')
          .split(' on').join('\non')
          .split(' using').join('\nusing')
          .split(' (').join(' (\n  ')
          .split(',').join('\n  ,')
          .split(');').join('\n);')
      },
      handleCopyStatus(status) {
        alert(status)
      },
      onCopy  () {
        alert('Copied!')
      },
      onError  (e) {
        alert('Failed to copy script to clipboard')
        console.error(e)
      },
      executeSql () {
        this.$apollo.mutate({
          mutation: execSql,
          variables: {
            sql: this.scriptText
          }
        })
        .then(result => {
          console.log('result', result)
          this.activeTab = 1
          this.results = JSON.stringify(result.data.ExecSql.result,null,2)
          // this.results = result.data.ExecSql.result.rows
        })
        .catch(error => {
          this.activeTab = 1
          this.results = error.toString()
        })
      }
    },
    data: () => ({
      activeTab: 0,
      allPolicies: [],
      results: null,
      schemaPolicy: 'NOT CALCULATED',
      defaultRlsPolicies: 'NOT CALCULATED',
      defaultNoRlsPolicies: 'NOT CALCULATED',
      selectedTabName: '',
      readability: 'terse',
      declarationVisibility: 'show'
    })
  }
</script>

<style>

</style>
