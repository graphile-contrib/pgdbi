
<template>
  <v-data-table
    :headers="headers"
    :items="rlsQualifierMatrix"
    hide-actions
    item-key="id"
    class="text-sm-left"
  >
    <template slot="items" slot-scope="props">
      <td>{{ props.item.roleName }}</td>          
      <td v-for="action in ['all', 'select', 'insert', 'update', 'delete']" :key="action">
        <v-btn
          @click="addRlsPolicy(props.item.roleName, action)"
          :hidden="disabled"
        >Add Policy</v-btn>
        <rls-policy-dialog
          v-for="(policy) in props.item[action].policies"
          :key="`${policy.roleName}-${policy.id}`"
          :action="action"
          :roleName="props.item.roleName"
          :rlsPolicy="policy"
          :status="'ENABLED'"
          :disableRlsPolicy="disableRlsPolicy"
          :updateRlsPolicy="updateRlsPolicy"
          :disabled="disabled"
        ></rls-policy-dialog>
        <rls-policy-dialog
          v-for="(policy) in impliedPolicies(props.item.roleName, action)"
          :key="`${policy.roleName}-${policy.id}`"
          :action="action"
          :roleName="props.item.roleName"
          :rlsPolicy="policy"
          :status="'IMPLIED'"
          :disableRlsPolicy="disableRlsPolicy"
          :updateRlsPolicy="updateRlsPolicy"
          :disabled="disabled"
        ></rls-policy-dialog>
      </td>
    </template>
  </v-data-table>
</template>

<script>
  const ENABLED = 'ENABLED'
  const DISABLED = 'DISABLED'
  const IMPLIED = 'IMPLIED'
  import RlsPolicyDialog from '@/components/TableSecurity/Dialogs/RlsPolicyDialog.vue'

  export default {
    name: 'PolicyRlsQualifierGrid',
    components: {
      RlsPolicyDialog
    },
    props: {
      policy: {
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
        toggleCompleted: false,
        dialog: false,
        currentUsing: 'n/a',
        currentWithCheck: 'n/a'
      }
    },
    watch: {
    },
    methods: {
      impliedPolicies(roleName, action) {
        // todo:  detect implied roles that are not in the same family - this should probably be a special family as it likely indicates a mistake
        const impliedRoleNames = this.projectRoles
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

      },
      rlsQualifierCheckLabel(rlsPolicy, action) {
        switch(rlsPolicy[action].status) {
          case ENABLED:
            return 'Add Policy'
            break;
          case DISABLED:
            return 'Enable'
            break;
          case IMPLIED:
            return 'Add Policy'
            break;
        }
      },
    },
    computed: {
      projectRoles () {
        return this.$store.state.projectRoles
      },
      defaultRLSQual () {
        return this.$store.state.defaultRLSQual
      },
      rlsQualifierMatrix () {
        return Object.keys(this.policy.rlsQualifiers).map(
          roleName => {
            return {
              ...this.policy.rlsQualifiers[roleName]
              ,roleName: roleName
            }
          }
        )
      },
      headers () {
        return [
          {
            text: 'Role Name',
            sortable: false
          },
          {
            text: 'ALL',
            sortable: false
          },
          {
            text: 'SELECT',
            sortable: false
          },
          {
            text: 'INSERT',
            sortable: false
          },
          {
            text: 'UPDATE',
            sortable: false
          },
          {
            text: 'DELETE',
            sortable: false
          }
        ]
      },
    },
  }
</script>

<style>
.norm-text {
  text-transform: none !important;
}
</style>