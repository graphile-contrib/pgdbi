<template>
  <div>
    <h1>Export Project</h1>
      <v-toolbar>
        <v-btn @click="exportProject">Save</v-btn>
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
  name: "ExportProject",
  components: {
  },
  props: {
  },
  computed: {
    projectName () {
      return this.project ? this.project.name : 'N/A'
    },
    projectJson () {
      return JSON.stringify(this.$store.state,0,2)
    }
  },
  methods: {
    exportProject: function() {
        const data = this.projectJson
        const blob = new Blob([data], {type: 'text/plain'})
        const e = document.createEvent('MouseEvents'),
        a = document.createElement('a');
        a.download = 'pgdbi.json';
        // a.download = `${this.project.name}-${this.project.id}.json`;          
        a.href = window.URL.createObjectURL(blob);
        a.dataset.downloadurl = ['text/json', a.download, a.href].join(':');
        e.initEvent('click', true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
        a.dispatchEvent(e);
    },
  }
}
</script>