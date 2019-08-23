export default {
  initializing: true,
  schemaFilterOn: true,
  policies: [],
  tablePolicyAssignments: {},
  functionPolicies: [],
  functionPolicyAssignments: {},
  defaultPolicy: null,
  defaultFunctionPolicy: null,
  managedSchemata: [],
  parkedSchemata: [],
  rawSchemata: [],
  schemaFilter: [],
  enabledRoles: [],
  projectRoles: [],
  selectedRoleFamilies: [],
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
  functionPolicyHeaderTemplate: `
  ----------  BEGIN: {{schemaName}}.{{functionName}}
  
  `,
  functionPolicyFooterTemplate: `

  ----------  END: {{schemaName}}.{{functionName}}`,
  defaultFunctionRoleGrants: {
    execute: 'DENIED',
  },
};
