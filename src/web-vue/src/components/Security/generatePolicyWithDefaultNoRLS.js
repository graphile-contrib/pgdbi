export default function generatePolicyWithDefaultNoRLS(schemaName, tableName, userRole, superAdminRole) {
  return `
--=================== ${schemaName}.${tableName}  ===================

  --  REMOVE ALL SECURITY
  REVOKE ALL PRIVILEGES ON ${schemaName}.${tableName} FROM PUBLIC;
  ALTER TABLE ${schemaName}.${tableName} DISABLE ROW LEVEL SECURITY;
  DROP POLICY IF EXISTS all_${tableName}_${userRole} ON ${schemaName}.${tableName};
  DROP POLICY IF EXISTS all_${tableName}_${superAdminRole} ON ${schemaName}.${tableName};
  --||--

  ----------------  GRANTS ----------------
  GRANT select, update, delete ON TABLE ${schemaName}.${tableName} TO ${userRole};

--=================== ${schemaName}.${tableName}  ===================
`     
}
