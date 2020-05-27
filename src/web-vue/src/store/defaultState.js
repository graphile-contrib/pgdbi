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
  dbOwnerRole: {
    roleName: 'app_owner',
  },
  dbAuthenticatorRole: {
    roleName: 'app_authenticator',
  },
  dbAnonymousRole: {
    roleName: 'app_anonymous'
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
      applicableRoles: [],
      isAnonymous: true
    }
  ],
  // enabledRoles: [],
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
  //     roleName: 'app_anoymous',
  //     applicableRoles: []
  //   }
  // ],
  // ignoredRoles: [],
  // selectedRoleFamilies: [],
  defaultRlsUsing: '( owner_id = viewer_id() )',
  // defaultRlsUsing: '(auth_fn.app_user_has_access(app_tenant_id) = true)',
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
  functionPolicyHeaderTemplate: `
  ----------  BEGIN: {{schemaName}}.{{functionName}}
  
  `,
  functionPolicyFooterTemplate: `

  ----------  END: {{schemaName}}.{{functionName}}`,
  defaultFunctionRoleGrants: {
    execute: 'DENIED',
  },
};
