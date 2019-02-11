<template>
  <v-container>
    <v-textarea
      :value="policy"
      auto-grow
    ></v-textarea>
    <!-- <security-policy
      :appRoles="selectedAppRoles"
      :tableItem="tableItem"
    ></security-policy> -->
    <!-- SECURITY
    <v-tabs
      dark
      slider-color="yellow"
    >
      <v-tab
        key="rendered"
        ripple
      >
        Rendered
      </v-tab>
      <v-tab-item
        key="rendered"
      >
        <v-data-table
          :headers="headers"
          :items="items"
          hide-actions
          item-key="id"
        >
            <template slot="items" slot-scope="props">
              <tr @click="props.expanded = !props.expanded">        
                <td
                  key="schemaName"
                >{{props.item.schemaName}}</td>
                <td
                  key="tableName"
                >{{props.item.tableName}}</td>
                <td
                  key="policyCount"
                >
                  {{props.item.policyCount}}
                  <v-icon small :color="props.item.policyColor">fiber_manual_record</v-icon>
                </td>
                <td
                  key="roleTableGrantCount"
                >{{props.item.roleTableGrantCount}}</td>
                <td
                  key="roleColumnGrantCount"
                >{{props.item.roleColumnGrantCount}}</td>
              </tr>
            </template>

          <template slot="expand" slot-scope="props">
            <v-tabs
              dark
              slider-color="yellow"
            >
              <v-tab
                key="rls-policies"
                ripple
              >
                RLS Policies
              </v-tab>
              <v-tab-item
                key="rls-policies"
              >
                <v-card color="blue">
                  <v-container>
                    <table-policies
                      :policies="props.item.policies"
                    ></table-policies>
                  </v-container>
                </v-card>
              </v-tab-item>

              <v-tab
                key="table-grants"
                ripple
              >
                Table Grants
              </v-tab>
              <v-tab-item
                key="table-grants"
              >
                <v-card color="blue">
                  <v-container>
                    <table-grants
                      :grants="props.item.roleTableGrants"
                    ></table-grants>
                  </v-container>
                </v-card>
              </v-tab-item>
            </v-tabs>
          </template>
        </v-data-table>
      </v-tab-item>
    </v-tabs> -->
  </v-container>
</template>

<script>
  import getDbSecurityTree from '@/gql/query/getDbSecurityTree.graphql'
  import getDbSecurityTreeFiltered from '@/gql/query/getDbSecurityTreeFiltered.graphql'
  import TablePolicies from '@/components/Table/TablePolicies'
  import TableGrants from '@/components/Table/TableGrants'
  import SecurityPolicy from './SecurityPolicy.vue'

  export default {
    name: 'Security',
    components: {
      TablePolicies,
      TableGrants,
      SecurityPolicy
    },
    props: {
    },
    computed: {
      selectedAppRoles () {
        return this.$store.state.roleFilter
      },
      tableItem () {
        return (this.securityTree.find(s => s.schemaName === 'org') || {schemaTables: []}).schemaTables.find(t => t.tableName === 'organization') || {tableName: 'nada'}
      },
      definition () {
        return this.fn.definition
      },
      schemaFilter () {
        return this.$store.state.schemaFilter
      },
      items () {
        return this.securityTree.reduce(
          (rows, schema) => {
            const schemaTableRows = schema.schemaTables.map(
              table => {
                return {
                  id: table.id,
                  schemaName: table.tableSchema,
                  tableName: table.tableName,
                  policyCount: table.policies.length,
                  policyColor: table.policies.length > 0 ? 'green' : 'red',
                  policyText: table.policies.length === 0 ? 'no policies' : table.policies.reduce(
                    (text, policy) => {
                      return text.concat(`${policy.cmd} - ${policy.cmd} - ${policy.qual}`)
                    }, ''
                  ),
                  policies: table.policies,
                  roleTableGrants: table.roleTableGrants,
                  roleTableGrantCount: table.roleTableGrants.length,
                  roleColumnGrantCount: table.roleColumnGrants.length
                }
              }
            )

            return rows.concat(schemaTableRows)
          }, []
        )
      },
      // policy () {
      //   return this.securityTree.reduce(
      //     (policy, schema) => {
      //        return policy.concat(this.generatePolicy(schema.schemaName, 'lf_inventory_item', 'soro_user', 'soro_super_admin', 'seller_id'))
      //     }, ''
      //   )
      // }
    },
    methods: {
      calculatePolicy () {
        console.log('calc', this.securityTree)
        this.policy = this.securityTree.reduce(
          (policy, schema) => {
             return policy.concat(this.generatePolicy(schema.schemaName, 'lf_inventory_item', 'soro_user', 'soro_super_admin', 'seller_id'))
          }, ''
        )
      },
      generatePolicy(schemaName, tableName, userRole, superAdminRole, tenantIdField) {
        return `
      
--  remove all security for ${schemaName}
`     
      }
//       generatePolicy(schemaName, tableName, userRole, superAdminRole, tenantIdField) {
//         return `
// --  remove all security for ${schemaName}.${tableName}
// // REVOKE ALL PRIVILEGES ON ${schemaName}.${tableName} FROM PUBLIC;
// // ALTER TABLE ${schemaName}.${tableName} DISABLE ROW LEVEL SECURITY;
// // DROP POLICY IF EXISTS all_${tableName}_${userRole} ON ${schemaName}.${tableName};
// // DROP POLICY IF EXISTS all_${tableName}_${superAdminRole} ON ${schemaName}.${tableName};
// // --||--
// // --  define security for ${schemaName}.${tableName}
// // GRANT select, update, delete ON TABLE ${schemaName}.${tableName} TO ${userRole};
// // ALTER TABLE ${schemaName}.${tableName} ENABLE ROW LEVEL SECURITY;
// // -- user are limited to tenant
// // CREATE POLICY all_${tableName}_${userRole} ON ${schemaName}.${tableName} FOR SELECT to ${userRole}
// // USING ((${tenantIdField} = soro.viewer_company_id()));
// // -- super admin can see everything
// // CREATE POLICY all_${tableName}_${superAdminRole} ON ${schemaName}.${tableName} FOR SELECT to ${superAdminRole}
// // USING (1 = 1);
// // -- 
// // CREATE INDEX IF NOT EXISTS idx_${tableName}_${tenantIdField} ON ${schemaName}.${tableName}(${tenantIdField});
// `     
//       }
    },
    // watch: {
    //   securityTree () {
    //     this.calculatePolicy()
    //   }
    // },
    data: () => ({
      securityTree: [],
      policyHeaders: [
        {text: 'roles', value: 'roles'},
        {text: 'cmd', value: 'cmd'},
        {text: 'qual', value: 'qual'}
      ],
      headers: [
        {text: 'schema name', value: 'schemaName'},
        {text: 'table name', value: 'tableName'},
        {text: 'policy', value: 'policyCount'},
        {text: 'table grant', value: 'roleTableGrantCount'},
        {text: 'column grants', value: 'roleColumnGrantCount'}
      ],
      policy: 'NOT CALCULATED'
    }),
    apollo: {
      init: {
        query () {
          return this.schemaFilter.length > 0 ? getDbSecurityTreeFiltered : getDbSecurityTree
        },
        variables () {
          return this.schemaFilter.length > 0 ? { filter: this.schemaFilter.map(f => f.split(':')[1]) } : {}
        },
        update (result) {
          this.securityTree = result.allSchemata.nodes
          console.log('wtf', this.securityTree)
          this.calculatePolicy()
        }
      }
    }
    // created () {
    //   this.getDbSchemaTree()
    // }
  }
</script>

<style>

</style>
