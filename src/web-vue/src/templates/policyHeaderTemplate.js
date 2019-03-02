module.exports = `
--=================== {{schemaName}}.{{tableName}}  ===================

  --  REMOVE ALL SECURITY
  revoke all privileges on {{schemaName}}.{{tableName}} from public;
  alter table {{schemaName}}.{{tableName}} disable row level security;
  --  END REMOVE ALL SECURITY

`