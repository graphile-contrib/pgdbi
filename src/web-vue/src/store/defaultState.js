import defaultRoleSets from './defaultRoleSets'

export default {
  allRoleSets: defaultRoleSets,
  pgdbiOptions: {},
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
  roleSet: {
    dbOwnerRole: {},
    dbAuthenticatorRole: {},
    dbUserRoles: [],
  },
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


