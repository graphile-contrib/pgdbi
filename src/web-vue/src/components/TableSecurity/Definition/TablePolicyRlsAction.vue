
<template>
  <v-container>
    <v-btn
      small
      @click="addRlsPolicy(item.roleName, action)"
      :hidden="disabled"
    >Add Policy</v-btn>
    <rls-policy-dialog
      v-for="(policy) in item[action].policies"
      :key="`${policy.roleName}-${policy.id}`"
      :action="action"
      :roleName="item.roleName"
      :rlsPolicy="policy"
      :status="'ENABLED'"
      :disableRlsPolicy="disableRlsPolicy"
      :updateRlsPolicy="updateRlsPolicy"
      :disabled="disabled"
    ></rls-policy-dialog>
    <rls-policy-dialog
      v-for="(policy) in impliedPolicies(item.roleName, action)"
      :key="`${policy.roleName}-${policy.id}`"
      :action="action"
      :roleName="item.roleName"
      :rlsPolicy="policy"
      :status="'IMPLIED'"
      :disableRlsPolicy="disableRlsPolicy"
      :updateRlsPolicy="updateRlsPolicy"
      :disabled="disabled"
    ></rls-policy-dialog>
  </v-container>
</template>

<script>
  const ENABLED = 'ENABLED'
  const DISABLED = 'DISABLED'
  const IMPLIED = 'IMPLIED'
  import RlsPolicyDialog from '@/components/TableSecurity/Dialogs/RlsPolicyDialog.vue'

  export default {
    name: 'PolicyRlsAction',
    components: {
      RlsPolicyDialog
    },
    props: {
      policy: {
        type: Object,
        required: true
      },
      action: {
        type: String,
        required: true
      },
      item: {
        type: Object,
        required: true
      },
      disabled: {
        type: Boolean,
        default: false
      }
    },
    data () {
      return {
      }
    },
    watch: {
    },
    methods: {
      impliedPolicies(roleName, action) {
        // todo:  detect implied roles that are not in the same family - this should probably be a special family as it likely indicates a mistake
        const impliedRoleNames = this.dbUserRoles
          .find(pr => pr.roleName === roleName)
          .applicableRoles
          .reduce((a,r)=>{ return a.concat(r.roleName)}, [])
          .concat([roleName])
          
        const impliedRlsPolicies = impliedRoleNames
          .reduce(
            (ip, impliedRoleName) => {
              if (impliedRoleName !== roleName) {
                return action === 'all'
                  ? ip.concat(this.policy.rlsQualifiers[impliedRoleName][action].policies)
                  : ip.concat(this.policy.rlsQualifiers[impliedRoleName][action].policies).concat(this.policy.rlsQualifiers[impliedRoleName].all.policies)
              } else {
                return action === 'all'
                  ? ip
                  : ip
                    .concat(this.policy.rlsQualifiers[impliedRoleName].all.policies)
              }
            }, []
          )

        return impliedRlsPolicies
      },
      addRlsPolicy(roleName, action){
        this.$store.commit('createRlsPolicy', {
          policyId: this.policy.id,
          roleName: roleName,
          action: action
        })
      },
      disableRlsPolicy (roleName, action, rlsPolicyId) {
        this.$store.commit('deleteRlsPolicy', {
          policyId: this.policy.id,
          roleName: roleName,
          action: action,
          rlsPolicyId: rlsPolicyId
        })
      },
      updateRlsPolicy (roleName, action, policyId, using, withCheck, passStrategy, name) {
        const policies = this.policy.rlsQualifiers[roleName][action].policies
          .filter(p => p.id !== policyId)
          .concat([{
            id: policyId
            ,using: using
            ,withCheck: withCheck
            ,passStrategy: passStrategy
            ,name: name
          }])

        const newPolicy = {
          ...this.policy,
          rlsQualifiers: {
            ...this.policy.rlsQualifiers,
            [roleName]: {
              ...this.policy.rlsQualifiers[roleName],
              [action]: {
                status: this.policy.rlsQualifiers[roleName][action].status,
                policies: policies,
                using: using,
                withCheck: withCheck,
                passStrategy: passStrategy
              }
            }
          }
        }

        this.$store.commit('savePolicy', {
            policy: newPolicy
          }
        )

      }
    },
    computed: {
      dbUserRoles () {
        return this.$store.state.dbUserRoles
      },
      // defaultRLSQual () {
      //   return this.$store.state.defaultRLSQual
      // },
    },
  }
</script>

<style>
.norm-text {
  text-transform: none !important;
}
</style>