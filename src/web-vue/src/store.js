import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'

import policyHeaderTemplate from './templates/policyHeaderTemplate.js'
import policyFooterTemplate from './templates/policyFooterTemplate.js'
import roleTableGrantTemplate from './templates/roleTableGrantTemplate.js'

Vue.use(Vuex)



const defaultRoleGrants = {
  all: 'DENIED',
  select: 'DENIED',
  insert: 'DENIED',
  update: 'DENIED',
  delete: 'DENIED',
}

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
  console.log('wtf, indeed', name)
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

// const defaultPolicy = buildNewPolicy('Default Policy', [])

const defaultState = {
  policies: [],
  defaultPolicy: null,
  managedSchemata: [],
  parkedSchemata: [],
  rawSchemata: [],
  schemaFilter: [],
  projectRoles: [],
  selectedRoleFamilies: [],
  policyHeaderTemplate: policyHeaderTemplate,
  policyFooterTemplate: policyFooterTemplate,
  roleTableGrantTemplate: roleTableGrantTemplate,
  defaultRlsUsing: '(auth_fn.app_user_has_access(app_tenant_id) = true)',
  defaultRlsWithCheck: ''
}

export default new Vuex.Store({
  plugins: [createPersistedState()],
  state: {
    policies: defaultState.policies,
    defaultPolicy: null,
    managedSchemata: defaultState.managedSchemata,
    parkedSchemata: defaultState.parkedSchemata,
    rawSchemata: defaultState.rawSchemata,
    schemaFilter: defaultState.schemaFilter,
    projectRoles: defaultState.projectRoles,
    selectedRoleFamilies: defaultState.selectedRoleFamilies,
    policyHeaderTemplate: defaultState.policyHeaderTemplate,
    policyFooterTemplate: defaultState.policyFooterTemplate,
    roleTableGrantTemplate: defaultState.roleTableGrantTemplate,
    defaultRlsUsing: defaultState.defaultRlsUsing,
    defaultRlsWithCheck: defaultState.defaultRlsWithCheck
  },
  mutations: {
    initialize (state) {
      if (state.policies.length === 0) {
        state.policies = []
        state.defaultPolicy = null
      }
    },
    resetDefaultState (state) {
      state.policies = defaultState.policies
      state.defaultPolicy = defaultState.defaultPolicy
      state.managedSchemata = defaultState.managedSchemata
      state.parkedSchemata = defaultState.parkedSchemata
      state.rawSchemata = defaultState.rawSchemata
      state.schemaFilter = defaultState.schemaFilter
      state.projectRoles = defaultState.projectRoles
      state.selectedRoleFamilies = defaultState.selectedRoleFamilies
      state.policyHeaderTemplate = defaultState.policyHeaderTemplate
      state.policyFooterTemplate = defaultState.policyFooterTemplate
      state.roleTableGrantTemplate = defaultState.roleTableGrantTemplate
      state.defaultRlsUsing = defaultState.defaultRlsUsing
      state.defaultRlsWithCheck = defaultState.defaultRlsWithCheck
    },
    rawSchemata (state, payload) {
      state.rawSchemata = payload.rawSchemata
    },
    setManagedSchemata (state, payload) {
      const defaultPolicy = {
        id: (((new Date()).getTime() * 10000) + 621355968000000000),
        name: 'Default Policy',
        policyHeaderTemplate: policyHeaderTemplate,
        policyFooterTemplate: policyFooterTemplate,
        roleTableGrantTemplate: roleTableGrantTemplate,
        enableRls: true,
        roleGrants: state.projectRoles.reduce(
          (all, projectRole) => {
            return {
              ...all,
              [projectRole.roleName]: defaultRoleGrants
            }
          }, {}
        ),
        rlsQualifiers: state.projectRoles.reduce(
          (all, projectRole) => {
            return {
              ...all,
              [projectRole.roleName]: defaultRlsQualifiers
            }
          }, {}
        )
      }

      if (!state.defaultPolicy) {
        state.defaultPolicy = defaultPolicy
        state.policies = state.policies.concat([defaultPolicy])
      }

      const schemataToRemainManaged = state.managedSchemata
        .reduce(
          (all, schema) => {
            return payload.find(s => s.id === schema.id) ? all.concat([schema]) : all
          }, []
        )

      const schemataToPark = state.managedSchemata
        .reduce(
          (all, schema) => {
            return payload.find(s => s.id === schema.id) ? all : all.concat([schema])
          }, []
        )

      const schemataToUnPark = state.parkedSchemata
      .reduce(
        (all, schema) => {
          return payload.find(s => s.id === schema.id) ? all.concat([schema]) : all
        }, []
      )

      const schemataToRemainParked = state.parkedSchemata
      .reduce(
        (all, schema) => {
          return schemataToUnPark.find(s => s.id === schema.id) ? all : all.concat([schema])
        }, []
      )

      const newlyManagedSchemata = payload.reduce(
        (all, schema) => {
          return schemataToUnPark.concat(schemataToRemainManaged).find(s => s.id === schema.id) ? all : all.concat([schema])
        }, []
      ).map(
        schema => {
          return {
            ...schema,
            schemaTables: schema.schemaTables.map(
              table => {
                return {
                  ...table,
                  policyDefinitionId: table.policyDefinitionId || state.defaultPolicy.id
                }
              }
            )
          }          
        }
      )
      state.managedSchemata = schemataToUnPark.concat(newlyManagedSchemata).concat(schemataToRemainManaged)
      state.parkedSchemata = schemataToPark.concat(schemataToRemainParked)
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
