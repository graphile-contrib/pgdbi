<template>
  <div>
    <div class="container">
      <div class="large-12 medium-12 small-12 cell">
        <label>File
          <input type="file" id="file" ref="file" v-on:change="handleFileUpload()"/>
        </label>
      </div>
    </div>
    <h1>Import Project: {{ projectName }}</h1>
      <v-toolbar>
        <v-btn @click="importProject">Import</v-btn>
      </v-toolbar>
      <v-textarea
        :value="projectJson"
        auto-grow
        readonly
      ></v-textarea>
  </div>
</template>

<script>
export default {
  name: "ImportProject",
  components: {
  },
  props: {
  },
  computed: {
    projectName () {
      return this.project ? this.project.name : 'N/A'
    },
    projectJson () {
      return this.project ? JSON.stringify(this.project, null, 2) : 'N/A'
    }
  },
  methods: {
    importProject: function() {
      this.$store.commit('importProject', {
        project: this.project
      })
    },
    useResults (reader) {
      this.project = JSON.parse(reader.currentTarget.result)
    },
    handleFileUpload () {
      this.file = this.$refs.file.files[0];
      const reader = new FileReader();
      reader.onload = this.useResults
      reader.readAsText(this.file);
    },
    submitFile () {

    }
  },
  data () {
    this.$store.commit('clearFocus')
    return {
      file: '',
      project: {
        releases: {
          nodes: []
        }
      }
    }
  }
}
</script>