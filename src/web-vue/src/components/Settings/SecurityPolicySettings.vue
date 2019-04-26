<template>
  <v-container>
    <default-rls-using></default-rls-using>
    <!-- <table-policy-template></table-policy-template> -->
  </v-container>
</template>

<script>
// import TablePolicyTemplate from '@/components/Settings/TablePolicyTemplate'
import DefaultRlsUsing from '@/components/Settings/DefaultRlsUsing'

export default {
  name: 'SecurityPolicySettings',
  components: {
    // TablePolicyTemplate,
    DefaultRlsUsing
  },
  computed: {
  },
  methods: {
  },
  data () {
    return {
    }
  },
}
</script>

