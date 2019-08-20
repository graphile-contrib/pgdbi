
<template>
  <v-data-table
    :headers="headers"
    :items="rlsQualifierMatrix"
    hide-default-footer
    item-key="id"
    dense
  >
    <template v-slot:item.roleName="{ item }">
      <div class="text-no-wrap">{{ item.roleName }}</div>
    </template>

    <template v-slot:item.all="{ item }">
      <table-policy-rls-action
        :policy="policy"
        :action="'all'"
        :item="item"
        :disabled="disabled"
      >
      </table-policy-rls-action>
    </template>

    <template v-slot:item.select="{ item }">
      <table-policy-rls-action
        :policy="policy"
        :action="'select'"
        :item="item"
        :disabled="disabled"
      >
      </table-policy-rls-action>
    </template>

    <template v-slot:item.insert="{ item }">
      <table-policy-rls-action
        :policy="policy"
        :action="'insert'"
        :item="item"
        :disabled="disabled"
      >
      </table-policy-rls-action>
    </template>

    <template v-slot:item.update="{ item }">
      <table-policy-rls-action
        :policy="policy"
        :action="'update'"
        :item="item"
        :disabled="disabled"
      >
      </table-policy-rls-action>
    </template>

    <template v-slot:item.delete="{ item }">
      <table-policy-rls-action
        :policy="policy"
        :action="'delete'"
        :item="item"
        :disabled="disabled"
      >
      </table-policy-rls-action>
    </template>

    <!-- <template v-slot:item.select="{ item }">
      <v-btn
        @click="addRlsPolicy(item.roleName, 'select')"
        :hidden="disabled"
      >Add Policy</v-btn>
      <rls-policy-dialog
        v-for="(policy) in item['select'].policies"
        :key="`${policy.roleName}-${policy.id}`"
        :action="'select'"
        :roleName="item.roleName"
        :rlsPolicy="policy"
        :status="'ENABLED'"
        :disableRlsPolicy="disableRlsPolicy"
        :updateRlsPolicy="updateRlsPolicy"
        :disabled="disabled"
      ></rls-policy-dialog>
      <rls-policy-dialog
        v-for="(policy) in impliedPolicies(item.roleName, 'select')"
        :key="`${policy.roleName}-${policy.id}`"
        :action="'select'"
        :roleName="item.roleName"
        :rlsPolicy="policy"
        :status="'IMPLIED'"
        :disableRlsPolicy="disableRlsPolicy"
        :updateRlsPolicy="updateRlsPolicy"
        :disabled="disabled"
      ></rls-policy-dialog>
    </template>

    <template v-slot:item.insert="{ item }">
      <v-btn
        @click="addRlsPolicy(item.roleName, 'insert')"
        :hidden="disabled"
      >Add Policy</v-btn>
      <rls-policy-dialog
        v-for="(policy) in item['insert'].policies"
        :key="`${policy.roleName}-${policy.id}`"
        :action="'insert'"
        :roleName="item.roleName"
        :rlsPolicy="policy"
        :status="'ENABLED'"
        :disableRlsPolicy="disableRlsPolicy"
        :updateRlsPolicy="updateRlsPolicy"
        :disabled="disabled"
      ></rls-policy-dialog>
      <rls-policy-dialog
        v-for="(policy) in impliedPolicies(item.roleName, 'insert')"
        :key="`${policy.roleName}-${policy.id}`"
        :action="'insert'"
        :roleName="item.roleName"
        :rlsPolicy="policy"
        :status="'IMPLIED'"
        :disableRlsPolicy="disableRlsPolicy"
        :updateRlsPolicy="updateRlsPolicy"
        :disabled="disabled"
      ></rls-policy-dialog>
    </template>

    <template v-slot:item.update="{ item }">
      <v-btn
        @click="addRlsPolicy(item.roleName, 'update')"
        :hidden="disabled"
      >Add Policy</v-btn>
      <rls-policy-dialog
        v-for="(policy) in item['update'].policies"
        :key="`${policy.roleName}-${policy.id}`"
        :action="'update'"
        :roleName="item.roleName"
        :rlsPolicy="policy"
        :status="'ENABLED'"
        :disableRlsPolicy="disableRlsPolicy"
        :updateRlsPolicy="updateRlsPolicy"
        :disabled="disabled"
      ></rls-policy-dialog>
      <rls-policy-dialog
        v-for="(policy) in impliedPolicies(item.roleName, 'update')"
        :key="`${policy.roleName}-${policy.id}`"
        :action="'update'"
        :roleName="item.roleName"
        :rlsPolicy="policy"
        :status="'IMPLIED'"
        :disableRlsPolicy="disableRlsPolicy"
        :updateRlsPolicy="updateRlsPolicy"
        :disabled="disabled"
      ></rls-policy-dialog>
    </template>

    <template v-slot:item.delete="{ item }">
      <v-btn
        @click="addRlsPolicy(item.roleName, 'delete')"
        :hidden="disabled"
      >Add Policy</v-btn>
      <rls-policy-dialog
        v-for="(policy) in item['delete'].policies"
        :key="`${policy.roleName}-${policy.id}`"
        :action="'delete'"
        :roleName="item.roleName"
        :rlsPolicy="policy"
        :status="'ENABLED'"
        :disableRlsPolicy="disableRlsPolicy"
        :updateRlsPolicy="updateRlsPolicy"
        :disabled="disabled"
      ></rls-policy-dialog>
      <rls-policy-dialog
        v-for="(policy) in impliedPolicies(item.roleName, 'delete')"
        :key="`${policy.roleName}-${policy.id}`"
        :action="'delete'"
        :roleName="item.roleName"
        :rlsPolicy="policy"
        :status="'IMPLIED'"
        :disableRlsPolicy="disableRlsPolicy"
        :updateRlsPolicy="updateRlsPolicy"
        :disabled="disabled"
      ></rls-policy-dialog>
    </template> -->

  </v-data-table>
</template>

<script>
  const ENABLED = 'ENABLED'
  const DISABLED = 'DISABLED'
  const IMPLIED = 'IMPLIED'
  import RlsPolicyDialog from '@/components/TableSecurity/Dialogs/RlsPolicyDialog.vue'
  import TablePolicyRlsAction from '@/components/TableSecurity/Definition/TablePolicyRlsAction.vue'

  export default {
    name: 'PolicyRlsQualifierGrid',
    components: {
      RlsPolicyDialog,
      TablePolicyRlsAction
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
            sortable: false,
            value: 'roleName'
          },
          {
            text: 'ALL',
            sortable: false,
            value: 'all'
          },
          {
            text: 'SELECT',
            sortable: false,
            value: 'select'
          },
          {
            text: 'INSERT',
            sortable: false,
            value: 'insert'
          },
          {
            text: 'UPDATE',
            sortable: false,
            value: 'update'
          },
          {
            text: 'DELETE',
            sortable: false,
            value: 'delete'
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