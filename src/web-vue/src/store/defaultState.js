const roleSetOptions = [
  {
    name: 'graphile',
    roles: {
      dbOwnerRole: {
        roleName: 'app_owner',
        applicableRoles: []
      },
      dbAuthenticatorRole: {
        roleName: 'app_authenticator',
        applicableRoles: [ {roleName: 'app_visitor'}, {roleName: 'app_anonymous'} ]
      },
      dbUserRoles: [
        {
          roleName: 'app_visitor',
          applicableRoles: [ {roleName: 'app_anonymous'} ]
        },
        {
          roleName: 'app_anonymous',
          applicableRoles: []
        }    
        ],    
    }
  },
  {
    name: 'multi-level',
    roles: {
      dbOwnerRole: {
        roleName: 'app_owner',
        applicableRoles: []
      },
      dbAuthenticatorRole: {
        roleName: 'app_authenticator',
        applicableRoles: [ {roleName: 'app_super_admin'}, {roleName: 'app_admin'}, {roleName: 'app_user'}, {roleName: 'app_anonymous'} ]
      },
      dbUserRoles: [
        {
          roleName: 'app_super_admin',
          applicableRoles: [ {roleName: 'app_admin'}, {roleName: 'app_user'}, {roleName: 'app_anonymous'} ]
        },
        {
          roleName: 'app_admin',
          applicableRoles: [ {roleName: 'app_user'}, {roleName: 'app_anonymous'} ]
        },
        {
          roleName: 'app_user',
          applicableRoles: [ {roleName: 'app_anonymous'} ]
        },
        {
          roleName: 'app_anonymous',
          applicableRoles: []
        }
      ]    
    }
  }
]



export default {
  pgdbiOtions: {},
  initializing: true,
  schemaFilterOn: true,
  policies: [],
  tablePolicyAssignments: {},
  functionPolicies: [],
  functionPolicyAssignments: {},
  defaultPolicy: null,
  defaultPolicyPermissive: null,
  defaultFunctionPolicy: null,
  defaultDbUserPolicies: [],
  genericIndexEvaluations: {},
  fkIndexEvaluations: {
    singleColumn: {},
    multiColumn: {}
  },
  uqIndexEvaluations: {
    singleColumn: {},
    multiColumn: {}
  },
  indicesToDrop: {},
  indexEvaluations: {},
  managedSchemata: [],
  parkedSchemata: [],
  rawSchemata: [],
  schemaFilter: [],
  dbOwnerRole: roleSetOptions.find(rs=>rs.name==='graphile').roles.dbOwnerRole,
  dbAuthenticatorRole: roleSetOptions.find(rs=>rs.name==='graphile').roles.dbAuthenticatorRole,
  dbUserRoles: roleSetOptions.find(rs=>rs.name==='graphile').roles.dbUserRoles,
  // dbOwnerRole: {
  //   roleName: 'app_owner',
  //   applicableRoles: []
  // },
  // dbAuthenticatorRole: {
  //   roleName: 'app_authenticator',
  //   applicableRoles: [ {roleName: 'app_super_admin'}, {roleName: 'app_admin'}, {roleName: 'app_user'}, {roleName: 'app_anonymous'} ]
  // },
  // dbUserRoles: [
  //   {
  //     roleName: 'app_super_admin',
  //     applicableRoles: [ {roleName: 'app_admin'}, {roleName: 'app_user'}, {roleName: 'app_anonymous'} ]
  //   },
  //   {
  //     roleName: 'app_admin',
  //     applicableRoles: [ {roleName: 'app_user'}, {roleName: 'app_anonymous'} ]
  //   },
  //   {
  //     roleName: 'app_user',
  //     applicableRoles: [ {roleName: 'app_anonymous'} ]
  //   },
  //   {
  //     roleName: 'app_anonymous',
  //     applicableRoles: []
  //   }
  // ],
  defaultRlsUsing: '( owner_id = viewer_id() )',
  defaultRlsWithCheck: '',
  defaultRlsQualifiers: {
    all: {
      policies: [],
    },
    select: {
      policies: [],
    },
    insert: {
      policies: [],
    },
    update: {
      policies: [],
    },
    delete: {
      policies: [],
    },
  },
  defaultRoleGrants: {
    select: 'DENIED',
    insert: 'DENIED',
    update: 'DENIED',
    delete: 'DENIED',
  },
  defaultPermissiveRoleGrants: {
    select: 'ALLOWED',
    insert: 'ALLOWED',
    update: 'ALLOWED',
    delete: 'ALLOWED',
  },
  defaultImpliedRoleGrants: {
    select: 'IMPLIED',
    insert: 'IMPLIED',
    update: 'IMPLIED',
    delete: 'IMPLIED',
  },
  functionPolicyHeaderTemplate: `
  ----------  BEGIN: {{schemaName}}.{{functionName}}
  
  `,
  functionPolicyFooterTemplate: `

  ----------  END: {{schemaName}}.{{functionName}}`,
  defaultFunctionRoleGrants: {
    execute: 'DENIED',
  },
  defaultFunctionRoleGrantsPermissive: {
    execute: 'ALLOWED',
  },
  defaultFunctionRoleGrantsImplied: {
    execute: 'IMPLIED',
  },
};


