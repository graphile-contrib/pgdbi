
<template>
  <v-container>
    <v-textarea
      :value="tablePolicyEval"
      auto-grow
      hide-details
      background-color="black"
      disabled
    >
    </v-textarea>
    <v-data-table
      :headers="headers"
      :items="tablePolicyEvaluationItems"
      hide-default-footer
      item-key="id"
    >
      <template slot="items" slot-scope="props">
        <tr>
          <td>
            {{ props.item.roleName }}
          </td>
          <td>
            {{ props.item.action }}
          </td>
          <td>
            {{ props.item.status }}
          </td>
        </tr>
      </template>
    </v-data-table>
  </v-container>
</template>

<script>
  import TablePolicyEvaluatorCalculatorMixin from '@/components/TableSecurity/Evaluation/TablePolicyEvaluatorCalculatorMixin'

  export default {
    name: 'TablePolicyEvaluatorDetail',
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
            text: 'roleName',
            sortable: false
          },
          {
            text: 'action',
            sortable: false
          },
          {
            text: 'status',
            sortable: false
          },
        ]
      }
    },
    computed: {
      tablePolicyEval () {
        return JSON.stringify(this.tablePolicyEvaluation, 0, 2)
      },
      tablePolicyEvaluationItems () {
        return Object.keys(this.tablePolicyEvaluation).reduce(
          (items, status) => {
            return [...items, 
              ...this.tablePolicyEvaluation[status].map(
                item => {
                  return {
                    ...item,
                    id: `${item.roleName}-${item.action}`,
                    status: status
                  }
                }
              )
            ]
          }, []
        )
      }
    }
  }
</script>

<style>
.norm-text {
  text-transform: none !important;
}
</style>