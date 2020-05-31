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
          <function-policy-assignment-by-schema></function-policy-assignment-by-schema>
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
          <function-policy-assignment-by-policy></function-policy-assignment-by-policy>
        </v-tab-item>
      </v-tabs>
    </v-container>
</template>

<script>
  import FunctionPolicyAssignmentBySchema from './FunctionPolicyAssignmentBySchema.vue'
  import FunctionPolicyAssignmentByPolicy from './FunctionPolicyAssignmentByPolicy.vue'

  export default {
    name: 'FunctionPolicyAssignment',
    components: {
      FunctionPolicyAssignmentBySchema,
      FunctionPolicyAssignmentByPolicy
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