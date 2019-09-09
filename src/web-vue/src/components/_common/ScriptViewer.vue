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
          <v-btn v-on="on" @click="executeSql" disabled><v-icon>arrow_forward</v-icon>Execute</v-btn>
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
    <v-textarea
      :disabled="true"
      :value="formatScript(scriptText)"
      auto-grow
      spellcheck="false"
      background-color="black"
    ></v-textarea>
  </v-container>
</template>

<script>
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
        alert ('not implemented:  server config value will expose graphile extension to execute generated script')
      }
    },
    data: () => ({
      allPolicies: [],
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
