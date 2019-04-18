
<template>
  <v-data-table 
    :items="items" 
    :hide-actions="true"
    :hide-headers="false"
    :headers="headers"
  >
    <template slot="items" slot-scope="props">
      <td align="right"><v-icon color="green">fiber_manual_record</v-icon></td>
      <td align="left">{{ props.item.expectedCount }}</td>
      <td align="right"><v-icon color="blue">fiber_manual_record</v-icon></td>
      <td align="left">{{ props.item.extraCount }}</td>
      <td align="right"><v-icon color="yellow">fiber_manual_record</v-icon></td>
      <td align="left">{{ props.item.missingCount }}</td>
      <td align="right"><v-icon color="red">fiber_manual_record</v-icon></td>
      <td align="left">{{ props.item.unexpectedCount }}</td>
    </template>
  </v-data-table>
</template>

<script>
  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'

  export default {
    name: 'TablePolicyEvaluator',
    props: {
      policyDefinition: {
        type: Object,
        required: true
      },
      table: {
        type: Object,
        required: true
      }
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
            align: 'left',
            sortable: false
          },
          {
            text: '',
            sortable: false
          },
          {
            text: 'extra',
            align: 'left',
            sortable: false
          },
          {
            text: '',
            sortable: false
          },
          {
            text: 'missing',
            align: 'left',
            sortable: false
          },
          {
            text: '',
            sortable: false
          },
          {
            text: 'unexpected',
            align: 'left',
            sortable: false
          },
        ]
      }
    },
    computed: {
      expectedCount () {
        return (this.tablePolicyEvaluation.expected || []).length
      },
      items () {
        const tablePolicyEvaluation = this.tablePolicyEvaluation || {
          expected: [],
          missing: [],
          unexpected: [],
          extra: []
        }
        return [{
          expectedCount: tablePolicyEvaluation.expected.length,
          missingCount: tablePolicyEvaluation.missing.length,
          unexpectedCount: tablePolicyEvaluation.unexpected.length,
          extraCount: tablePolicyEvaluation.extra.length,
        }]

      },
      tablePolicyEvaluation () {
        // console.log('table', JSON.stringify(this.table.roleTableGrants,0,2))
        // console.log('policyDefinition', this.policyDefinition)

        const grantEvaluation = Object.keys(this.policyDefinition.roleGrants).reduce(
          (grantEval, roleName) => {
            return Object.keys(this.policyDefinition.roleGrants[roleName]).reduce(
              (grantEval, action) => {
                const expectedRoleAction = this.policyDefinition.roleGrants[roleName][action]
                const existingGrant = this.table.roleTableGrants.find(rg => rg.grantee === roleName && rg.privilegeType === action.toUpperCase())

                switch (expectedRoleAction) {
                  case ALLOWED:
                    if (existingGrant) {
                      return {
                        ...grantEval,
                        expected: [...grantEval.expected, existingGrant]
                      }
                    } else {
                      return {
                        ...grantEval,
                        missing: [...grantEval.missing, expectedRoleAction]
                      }
                    }
                  case DENIED:
                    if (existingGrant) {
                      return {
                        ...grantEval,
                        unexpected: [...grantEval.unexpected, ...[existingGrant]]
                      } 
                    } else {
                      return grantEval
                    }
                  case IMPLIED:
                    if (existingGrant) {
                      return {
                        ...grantEval,
                        extra: [...grantEval.extra, existingGrant]
                      }
                    } else {
                      return grantEval
                    }
                }
              }, grantEval
            )
          }, {
            expected: [],
            missing: [],
            extra: [],
            unexpected: []
          }
        )

        // console.log('grantEvaluation', JSON.stringify(grantEvaluation,0,2))

        return grantEvaluation
        // return `${this.policyDefinition.name} - ${this.table.name}`
      }
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