<template>
</template>

<script>
  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'

  export default {
    name: 'TablePolicyEvaluatorCalculator',
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
      }
    },
    computed: {
      grantStatusColors () {
        return {
          expected: 'green',
          missing: 'yellow',
          unexpected: 'red',
          extra: 'blue'
        }
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
                        expected: [...grantEval.expected, {
                          ...existingGrant,
                          statusColor: this.grantStatusColors.expected
                        }]
                      }
                    } else {
                      return {
                        ...grantEval,
                        missing: [...grantEval.missing, {
                          roleName,
                          expectedRoleAction,
                          action,
                          statusColor: this.grantStatusColors.missing
                        }]
                      }
                    }
                  case DENIED:
                    if (existingGrant) {
                      return {
                        ...grantEval,
                        unexpected: [...grantEval.unexpected, {
                          ...existingGrant,
                          statusColor: this.grantStatusColors.unexpected
                        }]
                      } 
                    } else {
                      return grantEval
                    }
                  case IMPLIED:
                    if (existingGrant) {
                      return {
                        ...grantEval,
                        extra: [...grantEval.extra, {
                          ...existingGrant,
                          statusColor: this.grantStatusColors.extra
                        }]
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