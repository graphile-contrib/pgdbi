<template>
    <v-container>
      <v-tabs
        dark
        slider-color="yellow"
      >
        <v-tab
          key="by-schema"
          ripple
        >
          By Schema
        </v-tab>
        <v-tab-item
          key="by-schema"
        >
          <table-policy-assignment-by-schema></table-policy-assignment-by-schema>
        </v-tab-item>
        <v-tab
          key="by-policy"
          ripple
        >
          By Policy
        </v-tab>
        <v-tab-item
          key="by-policy"
        >
          <table-policy-assignment-by-policy></table-policy-assignment-by-policy>
        </v-tab-item>
      </v-tabs>
    </v-container>
</template>

<script>
  import TablePolicyAssignmentBySchema from './TablePolicyAssignmentBySchema.vue'
  import TablePolicyAssignmentByPolicy from './TablePolicyAssignmentByPolicy.vue'

  export default {
    name: 'TablePolicyAssignment',
    components: {
      TablePolicyAssignmentBySchema,
      TablePolicyAssignmentByPolicy
    },
    methods: {
    },
    watch: {
    },
    computed: {
    },
    data: () => ({
    })
  }
</script>