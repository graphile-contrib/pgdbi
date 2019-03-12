import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'

import policyHeaderTemplate from './templates/policyHeaderTemplate.js'
import policyFooterTemplate from './templates/policyFooterTemplate.js'
import roleTableGrantTemplate from './templates/roleTableGrantTemplate.js'

Vue.use(Vuex)


const defaultState = {
  schemaFilter: [],
  projectRoles: [],
  selectedRoleFamilies: [],
  selectedRole: [],
  familyPolicySets: [],
  policyHeaderTemplate: policyHeaderTemplate,
  policyFooterTemplate: policyFooterTemplate,
  roleTableGrantTemplate: roleTableGrantTemplate,
  appTenantFieldName: 'app_tenant_id',
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

function buildNewPolicy (name, projectRoles) {
  return {
    id: (((new Date()).getTime() * 10000) + 621355968000000000),
    name: name,
    policyHeaderTemplate: policyHeaderTemplate,
    policyFooterTemplate: policyFooterTemplate,
    roleTableGrantTemplate: roleTableGrantTemplate,
    roleGrants: projectRoles.reduce(
      (all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]: {
            all: 'DENIED',
            select: 'DENIED',
            insert: 'DENIED',
            update: 'DENIED',
            delete: 'DENIED',
          }
        }
      }, {}
    ),
    rlsQualifiers: projectRoles.reduce(
      (all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]: {
            all: {
              status: 'DISABLED'
              ,using: defaultState.defaultRlsUsing
              ,withCheck: defaultState.defaultRlsWithCheck
            },
            select: {
              status: 'DISABLED'
              ,using: defaultState.defaultRlsUsing
              ,withCheck: defaultState.defaultRlsWithCheck
            },
            insert: {
              status: 'DISABLED'
              ,using: defaultState.defaultRlsUsing
              ,withCheck: defaultState.defaultRlsWithCheck
            },
            update: {
              status: 'DISABLED'
              ,using: defaultState.defaultRlsUsing
              ,withCheck: defaultState.defaultRlsWithCheck
            },
            delete: {
              status: 'DISABLED'
              ,using: defaultState.defaultRlsUsing
              ,withCheck: defaultState.defaultRlsWithCheck
            }
          }
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
          [projectRole.roleName]: existing || {
            all: 'DENIED',
            select: 'DENIED',
            insert: 'DENIED',
            update: 'DENIED',
            delete: 'DENIED',
          }
        }
      }, {}
    ),
    rlsQualifiers: projectRoles.reduce(
      (all, projectRole) => {
        const existing = Object.keys(policy.rlsQualifiers).find(rn => rn === projectRole.roleName)

        return existing ? all : {
          ...all,
          [projectRole.roleName]: {
            all: {
              status: 'DISABLED'
              ,using: defaultState.defaultRlsUsing
              ,withCheck: defaultState.defaultRlsWithCheck
            },
            select: {
              status: 'DISABLED'
              ,using: defaultState.defaultRlsUsing
              ,withCheck: defaultState.defaultRlsWithCheck
            },
            insert: {
              status: 'DISABLED'
              ,using: defaultState.defaultRlsUsing
              ,withCheck: defaultState.defaultRlsWithCheck
            },
            update: {
              status: 'DISABLED'
              ,using: defaultState.defaultRlsUsing
              ,withCheck: defaultState.defaultRlsWithCheck
            },
            delete: {
              status: 'DISABLED'
              ,using: defaultState.defaultRlsUsing
              ,withCheck: defaultState.defaultRlsWithCheck
            }
          }
        }
      }, {}
    )
  }
}

export default new Vuex.Store({
  plugins: [createPersistedState()],
  state: {
    schemaFilter: defaultState.schemaFilter,
    projectRoles: defaultState.projectRoles,
    selectedRoleFamilies: defaultState.selectedRoleFamilies,
    familyPolicySets: defaultState.familyPolicySets,
    appTenantFieldName: defaultState.appTenantFieldName,
    defaultRlsUsing: defaultState.defaultRlsUsing,
    defaultRlsWithCheck: defaultState.defaultRlsWithCheck,
    policyTemplateNoRls: defaultState.policyTemplateNoRls,
    policyTemplateRls: defaultState.policyTemplateRls,
    policyHeaderTemplate: policyHeaderTemplate,
    policyFooterTemplate: policyFooterTemplate,
    roleTableGrantTemplate: roleTableGrantTemplate,
    policies: []
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
      state.appTenantFieldName = defaultState.appTenantFieldName
      state.defaultRlsUsing = defaultState.defaultRlsUsing
      state .defaultRlsWithCheck = defaultState.defaultRlsWithCheck
      state.policyTemplateNoRls = defaultState.policyTemplateNoRls
      state.policyTemplateRls = defaultState.policyTemplateRls
      state.policies = [buildNewPolicy('Default Policy', state.projectRoles)]
    },
    schemaFilter (state, payload) {
      state.schemaFilter = payload.schemaFilter
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
    appTenantFieldName (state, payload) {
      state.appTenantFieldName = payload.appTenantFieldName
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
    }
  },
  actions: {

  }
})
