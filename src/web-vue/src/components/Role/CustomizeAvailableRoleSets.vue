<template>
  <v-container>
    <script-viewer
      :scriptText="availableRoleSets"
      :showReadability="false"
      skipFormat
      canEdit
    ></script-viewer>
  </v-container>
</template>

<script>
  import ScriptViewer from '@/components/_common/ScriptViewer'

  export default {
    name: 'CustomizeAvailableRoleSets',
    mixins: [
    ],
    components: {
      ScriptViewer
    },
    props: {
    },
    data () {
      return {
      }
    },
    mounted () {
    },
    watch: {
    },
    methods: {
    },
    computed: {
      availableRoleSets () {
        const roleSets = this.$store.state.allRoleSets
        return JSON.stringify(roleSets,0,2)
      }
    }
  }
</script>