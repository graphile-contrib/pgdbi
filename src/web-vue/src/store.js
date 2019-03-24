import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'

import policyHeaderTemplate from './templates/policyHeaderTemplate.js'
import policyFooterTemplate from './templates/policyFooterTemplate.js'
import roleTableGrantTemplate from './templates/roleTableGrantTemplate.js'

Vue.use(Vuex)


const defaultState = {
  rawSchemata: [],
  schemaFilter: [],
  projectRoles: [],
  selectedRoleFamilies: [],
  selectedRole: [],
  familyPolicySets: [],
  policyHeaderTemplate: policyHeaderTemplate,
  policyFooterTemplate: policyFooterTemplate,
  roleTableGrantTemplate: roleTableGrantTemplate,
  defaultRlsUsing: '(auth_fn.app_user_has_access(app_tenant_id) = true)',
  defaultRlsWithCheck: '',
  policyTemplateNoRls: `
  --=================== {{schemaName}}.{{tableName}}  ===================
  
    --  REMOVE ALL SECURITY
    REVOKE ALL PRIVILEGES ON {{schemaName}}.{{tableName}} FROM PUBLIC;
    ALTER TABLE {{schemaName}}.{{tableName}} DISABLE ROW LEVEL SECURITY;
    DROP POLICY IF EXISTS all_{{tableName}}_app_user ON {{schemaName}}.{{tableName}};
    DROP POLICY IF EXISTS all_{{tableName}}_app_super_admin ON {{schemaName}}.{{tableName}};
    --||--
  
    ----------------  GRANTS ----------------
    GRANT select, update, delete ON TABLE {{schemaName}}.{{tableName}} TO app_user;
  
  --=================== {{schemaName}}.{{tableName}}  ===================
  `,
  policyTemplateRls: `
  --=================== {{schemaName}}.{{tableName}}  ===================
  
    --  REMOVE ALL SECURITY
    REVOKE ALL PRIVILEGES ON {{schemaName}}.{{tableName}} FROM PUBLIC;
    ALTER TABLE {{schemaName}}.{{tableName}} DISABLE ROW LEVEL SECURITY;
    DROP POLICY IF EXISTS all_{{tableName}}_app_user ON {{schemaName}}.{{tableName}};
    DROP POLICY IF EXISTS all_{{tableName}}_app_super_admin ON {{schemaName}}.{{tableName}};
    --||--
  
    ----------------  GRANTS ----------------
    GRANT select, update, delete ON TABLE {{schemaName}}.{{tableName}} TO app_user;
  
    ----------------  ENABLE ROW LEVEL SECURITY ----------------
    ALTER TABLE {{schemaName}}.{{tableName}} ENABLE ROW LEVEL SECURITY;
  
    ----------------  USER POLICY ----------------
    CREATE POLICY all_{{tableName}}_app_user ON {{schemaName}}.{{tableName}} FOR SELECT to app_user
    USING (app_tenant_id = soro.viewer_company_id());
  
    ----------------  SUPER ADMIN POLICY ----------------
    CREATE POLICY all_{{tableName}}_app_super_admin ON {{schemaName}}.{{tableName}} FOR SELECT to app_super_admin
    USING (1 = 1);
  
    ----------------  MAKE SURE THE TENANT ID FIELD IS INDEXED ----------------
    CREATE INDEX IF NOT EXISTS idx_{{tableName}}_app_tenant_id ON {{schemaName}}.{{tableName}}(app_tenant_id);
  
    --=================== {{schemaName}}.{{tableName}}  ===================
  `
  ,policies: []
}

const defaultRoleGrants = {
  all: 'DENIED',
  select: 'DENIED',
  insert: 'DENIED',
  update: 'DENIED',
  delete: 'DENIED',
}

// const defaultRlsQualifiers = {
//   all: {
//     status: 'DISABLED'
//     ,policies: []
//   },
//   select: {
//     status: 'DISABLED'
//     ,policies: []
//   },
//   insert: {
//     status: 'DISABLED'
//     ,policies: []
//   },
//   update: {
//     status: 'DISABLED'
//     ,policies: []
//   },
//   delete: {
//     status: 'DISABLED'
//     ,policies: []
//   }
// }
const defaultRlsQualifiers = {
  all: {
    policies: []
  },
  select: {
    policies: []
  },
  insert: {
    policies: []
  },
  update: {
    policies: []
  },
  delete: {
    policies: []
  }
}


function buildNewRlsPolicy (using, withCheck, passStrategy, name) {
  const id = (((new Date()).getTime() * 10000) + 621355968000000000)
  return {
    id: id
    ,name: name || id
    ,using: using
    ,withCheck: withCheck
    ,passStrategy: passStrategy
  }
}

function buildNewPolicy (name, projectRoles) {
  return {
    id: (((new Date()).getTime() * 10000) + 621355968000000000),
    name: name,
    policyHeaderTemplate: policyHeaderTemplate,
    policyFooterTemplate: policyFooterTemplate,
    roleTableGrantTemplate: roleTableGrantTemplate,
    enableRls: true,
    roleGrants: projectRoles.reduce(
      (all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]: defaultRoleGrants
        }
      }, {}
    ),
    rlsQualifiers: projectRoles.reduce(
      (all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]: defaultRlsQualifiers
        }
      }, {}
    )
  }
}

function updatePolicyRoles (policy, projectRoles) {
  return {
    ...policy,
    roleGrants: projectRoles.reduce(
      (all, projectRole) => {
        const existing = Object.keys(policy.roleGrants).find(rn => rn === projectRole.roleName)

        return {
          ...all,
          [projectRole.roleName]: existing || defaultRoleGrants
        }
      }, {}
    ),
    rlsQualifiers: projectRoles.reduce(
      (all, projectRole) => {
        const existing = Object.keys(policy.rlsQualifiers).find(rn => rn === projectRole.roleName)

        return existing ? all : {
          ...all,
          [projectRole.roleName]: existing || defaultRlsQualifiers
        }
      }, {}
    )
  }
}

export default new Vuex.Store({
  plugins: [createPersistedState()],
  state: {
    rawSchemata: defaultState.rawSchemata,
    schemaFilter: defaultState.schemaFilter,
    projectRoles: defaultState.projectRoles,
    selectedRoleFamilies: defaultState.selectedRoleFamilies,
    defaultRlsUsing: defaultState.defaultRlsUsing,
    defaultRlsWithCheck: defaultState.defaultRlsWithCheck,
    policyTemplateNoRls: defaultState.policyTemplateNoRls,
    policyTemplateRls: defaultState.policyTemplateRls,
    policyHeaderTemplate: policyHeaderTemplate,
    policyFooterTemplate: policyFooterTemplate,
    roleTableGrantTemplate: roleTableGrantTemplate,
    policies: [],
    managedSchemata: [],
  },
  mutations: {
    initialize (state) {
      if (state.policies.length === 0) {
        state.policies = [buildNewPolicy('Default Policy', state.projectRoles)]
      }
    },
    resetDefaultState (state) {
      // state.schemaFilter = defaultState.schemaFilter
      // state.selectedRoleFamilies = defaultState.selectedRoleFamilies
      // state.familyPolicySets = defaultState.familyPolicySets
      // state.projectRoles = defaultState.projectRoles
      state.defaultRlsUsing = defaultState.defaultRlsUsing
      state .defaultRlsWithCheck = defaultState.defaultRlsWithCheck
      state.policyTemplateNoRls = defaultState.policyTemplateNoRls
      state.policyTemplateRls = defaultState.policyTemplateRls
      state.policies = [buildNewPolicy('Default Policy', state.projectRoles)]
      state.managedSchemata = []

    },
    rawSchemata (state, payload) {
      state.rawSchemata = payload.rawSchemata
    },
    managedSchemata (state, payload) {
      state.managedSchemata = payload.managedSchemata
    },
    schemaFilter (state, payload) {
      state.schemaFilter = payload.schemaFilter

      const defaultPolicy = state.policies.find(p => p.name === 'Default Policy')

      const schemataToPark = state.managedSchemata.reduce(
        (all, schema) => {
          return state.schemaFilter.indexOf(schema.id) > -1 ? all : all.concat([schema])
        }, []
      )

      const managedSchemata = state.schemaFilter.reduce(
        (all, schemaId) => {
          const alreadyManaged = state.managedSchemata.find(s => s.id === schemaId)
          const schemaToManage = alreadyManaged || state.rawSchemata.find(s => s.id === schemaId)
          const managed = {
            ...schemaToManage,
            schemaTables: schemaToManage.schemaTables.map(
              table => {
                return {
                  ...table,
                  policyDefinitionId: table.policyDefinitionId || defaultPolicy.id
                }
              }
            )
          }

          return all.concat([managed])
        }, []
      )
      .concat(schemataToPark)
      .map(
        schema => {
          const parked = state.schemaFilter.indexOf(schema.id) === -1
          return {
            ...schema,
            parked: parked
          }
        }
      )
      state.managedSchemata = managedSchemata
    },
    assignTablePolicy (state, payload) {
      const stuff = state.managedSchemata.reduce(
        (stuff, schema) => {
          if (stuff.currentSchema) {
            return stuff
          } else {
            const table = schema.schemaTables.find(t => t.id === payload.tableId)
            if (table) {
              return {
                ...stuff,
                currentSchema: schema,
                currentTable: table
              }
            } else {
              return stuff
            }
          }
        }, {
          currentSchema: null,
          currentTable: null
        }
      )

      const schema = stuff.currentSchema
      const table = stuff.currentTable

      const otherSchemata = state.managedSchemata.filter (s => s.id !== schema.id)
      const otherTables = schema.schemaTables.filter(t => t.id !== table.id)


      state.managedSchemata = [
        ...otherSchemata,
        {
          ...schema,
          schemaTables: [
            ...otherTables,
            {
              ...table,
              policyDefinitionId: payload.policyDefinitionId
            }
          ]
        }
      ]
    },
    projectRoles (state, payload) {
      state.projectRoles = payload.projectRoles

      state.policies = state.policies.map(
        policy => {
          return updatePolicyRoles(policy, payload.projectRoles)
        }
      )
    },
    selectedRoleFamilies (state, payload) {
      state.selectedRoleFamilies = payload.selectedRoleFamilies
    },
    familyPolicySets (state, payload) {
      state.familyPolicySets = payload.familyPolicySets
    },
    defaultRlsUsing (state, payload) {
      state.defaultRlsUsing = payload.defaultRlsUsing
    },
    defaultRlsWithCheck (state, payload) {
      state.defaultRlsWithCheck = payload.defaultRlsWithCheck
    },
    policyTemplateNoRls (state, payload) {
      state.policyTemplateNoRls = payload.policyTemplateNoRls
    },
    policyTemplateRls (state, payload) {
      state.policyTemplateRls = payload.policyTemplateRls
    },
    newPolicy(state, payload) {
      const existing = state.policies.find(p => p.name === payload.name)
      if (existing) {
        throw new Error('A policy with this name already exists')
      } else {
        const newPolicy = buildNewPolicy(payload.name, state.projectRoles)
  
        state.policies = [...state.policies, ...[newPolicy]].sort(function(a,b){ return a.id < b.id})
      }
    },
    savePolicy(state, payload) {
      const policies = state.policies.filter(p => p.name !== payload.policy.name)
      state.policies = [...policies, ...[payload.policy]].sort((a,b) => { return a.id - b.id })
    },
    createRlsPolicy(state, payload) {
      const policy = state.policies.find(p => p.id === payload.policyId)
      const otherPolicies = state.policies.filter(p => p.id !== payload.policyId)
      const roleName = payload.roleName
      const action = payload.action

      const newRlsPolicy = buildNewRlsPolicy(
        payload.using || defaultState.defaultRlsUsing
        ,payload.withCheck || defaultState.defaultRlsWithCheck
        ,payload.passStrategy || 'permissive'
        ,payload.name
      )

      const updatedPolicy = {
        ...policy,
        rlsQualifiers: {
          ...policy.rlsQualifiers,
          [roleName]: {
            ...policy.rlsQualifiers[roleName],
            [action]: {
              ...policy.rlsQualifiers[roleName][action],
              policies: [
                ...policy.rlsQualifiers[roleName][action].policies,
                ...[newRlsPolicy]
              ]
            }
          }
        }
      }

      state.policies = [...otherPolicies, ...[updatedPolicy]]
    },
    deleteRlsPolicy(state, payload) {
      const policy = state.policies.find(p => p.id === payload.policyId)
      const otherPolicies = state.policies.filter(p => p.id !== payload.policyId)
      const roleName = payload.roleName
      const action = payload.action
      const rlsPolicyId = payload.rlsPolicyId

      const updatedPolicy = {
        ...policy,
        rlsQualifiers: {
          ...policy.rlsQualifiers,
          [roleName]: {
            ...policy.rlsQualifiers[roleName],
            [action]: {
              ...policy.rlsQualifiers[roleName][action],
              policies: policy.rlsQualifiers[roleName][action].policies.filter(rp => rp.id !== rlsPolicyId)
            }
          }
        }
      }

      state.policies = [...otherPolicies, ...[updatedPolicy]]
    }
  },
  actions: {

  }
})
