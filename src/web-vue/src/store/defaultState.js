export default {
  initializing: true,
  schemaFilterOn: true,
  policies: [],
  defaultPolicy: null,
  managedSchemata: [],
  parkedSchemata: [],
  rawSchemata: [],
  schemaFilter: [],
  projectRoles: [],
  selectedRoleFamilies: [],
  policyHeaderTemplate: `
  --=================== BEGIN: {{schemaName}}.{{tableName}}  ===================
  
  `,
  policyFooterTemplate: `

  --=================== END: {{schemaName}}.{{tableName}}  ===================
  `,
  defaultRlsUsing: '(auth_fn.app_user_has_access(app_tenant_id) = true)',
  defaultRlsWithCheck: '',
  defaultRlsQualifiers: {
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
  },
  defaultRoleGrants: {
    all: 'DENIED',
    select: 'DENIED',
    insert: 'DENIED',
    update: 'DENIED',
    delete: 'DENIED',
  }
}