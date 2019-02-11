export default function generatePolicy(schemaName, tableName, userRole, superAdminRole, tenantIdField, includeRLS) {
  const a = `
--=================== ${schemaName}.${tableName}  ===================

  --  REMOVE ALL SECURITY
  REVOKE ALL PRIVILEGES ON ${schemaName}.${tableName} FROM PUBLIC;
  ALTER TABLE ${schemaName}.${tableName} DISABLE ROW LEVEL SECURITY;
  DROP POLICY IF EXISTS all_${tableName}_${userRole} ON ${schemaName}.${tableName};
  DROP POLICY IF EXISTS all_${tableName}_${superAdminRole} ON ${schemaName}.${tableName};
  --||--

  ----------------  GRANTS ----------------
  GRANT select, update, delete ON TABLE ${schemaName}.${tableName} TO ${userRole};

`
  const b = `
  ----------------  ENABLE ROW LEVEL SECURITY ----------------
  ALTER TABLE ${schemaName}.${tableName} ENABLE ROW LEVEL SECURITY;

  ----------------  USER POLICY ----------------
  CREATE POLICY all_${tableName}_${userRole} ON ${schemaName}.${tableName} FOR SELECT to ${userRole}
  USING ((${tenantIdField} = soro.viewer_company_id()));

  ----------------  SUPER ADMIN POLICY ----------------
  CREATE POLICY all_${tableName}_${superAdminRole} ON ${schemaName}.${tableName} FOR SELECT to ${superAdminRole}
  USING (1 = 1);

  ----------------  MAKE SURE THE TENANT ID FIELD IS INDEXED ----------------
  CREATE INDEX IF NOT EXISTS idx_${tableName}_${tenantIdField} ON ${schemaName}.${tableName}(${tenantIdField});
`

    const c = `
--=================== ${schemaName}.${tableName}  ===================
`     

return includeRLS ? a.concat(b).concat(c) : a.concat(c)
}
