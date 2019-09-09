
<template>
  <v-data-table 
    :items="items" 
    :hide-default-footer="true"
    :hide-headers="false"
    :headers="headers"
  >
    <template slot="items" slot-scope="props">
      <td align="right"><v-icon :color="props.item.expectedColor">fiber_manual_record</v-icon></td>
      <td align="left">{{ props.item.expectedCount }}</td>
      <td align="right"><v-icon :color="props.item.extraColor">fiber_manual_record</v-icon></td>
      <td align="left">{{ props.item.extraCount }}</td>
      <td align="right"><v-icon :color="props.item.missingColor">fiber_manual_record</v-icon></td>
      <td align="left">{{ props.item.missingCount }}</td>
      <td align="right"><v-icon :color="props.item.unexpectedColor">fiber_manual_record</v-icon></td>
      <td align="left">{{ props.item.unexpectedCount }}</td>
    </template>
  </v-data-table>
</template>

<script>
  import TablePolicyEvaluatorCalculatorMixin from '@/components/TableSecurity/Evaluation/TablePolicyEvaluatorCalculatorMixin'

  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'

  export default {
    name: 'TablePolicyEvaluatorSummary',
    mixins: [
      TablePolicyEvaluatorCalculatorMixin
    ],
    props: {
    },
    mounted () {
    },
    data () {
      return {
        headers: [
          {
            text: '',
            sortable: false
          },
          {
            text: 'expected',
              sortable: false
          },
          {
            text: '',
            sortable: false
          },
          {
            text: 'extra',
              sortable: false
          },
          {
            text: '',
            sortable: false
          },
          {
            text: 'missing',
              sortable: false
          },
          {
            text: '',
            sortable: false
          },
          {
            text: 'unexpected',
              sortable: false
          },
        ]
      }
    },
    computed: {
      items () {
        const tablePolicyEvaluation = this.tablePolicyEvaluation || {
          expected: [],
          missing: [],
          unexpected: [],
          extra: []
        }
        return [{
          expectedCount: tablePolicyEvaluation.expected.length,
          expectedColor: (tablePolicyEvaluation.expected.length > 0 ? this.grantStatusColors.expected : 'grey'),
          missingCount: tablePolicyEvaluation.missing.length,
          missingColor: (tablePolicyEvaluation.missing.length > 0 ? this.grantStatusColors.missing : 'grey'),
          unexpectedCount: tablePolicyEvaluation.unexpected.length,
          unexpectedColor: (tablePolicyEvaluation.unexpected.length > 0 ? this.grantStatusColors.unexpected : 'grey'),
          extraCount: tablePolicyEvaluation.extra.length,
          extraColor: (tablePolicyEvaluation.extra.length > 0 ? this.grantStatusColors.extra : 'grey'),
        }]

      },
    },
    watch: {
    },
    methods: {
    }
  }
</script>

<style>
.norm-text {
  text-transform: none !important;
}
</style>