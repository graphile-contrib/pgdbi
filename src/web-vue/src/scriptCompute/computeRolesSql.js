function computeDbOwnerRoleSql (state) {
  const dbOwnerRole = state.roleSet.dbOwnerRole
  return `
------------  DB OWNER ROLE ------------
DO
$body$
BEGIN
  IF NOT EXISTS (
    SELECT    *
    FROM   pg_catalog.pg_roles
    WHERE  rolname = '${dbOwnerRole.roleName}')
  THEN
    CREATE ROLE ${dbOwnerRole.roleName};
  END IF;

  ALTER ROLE ${dbOwnerRole.roleName} with LOGIN;
  ALTER ROLE ${dbOwnerRole.roleName} with CREATEDB;

END
$body$;
--||--
---------- END DB OWNER ROLE -----------
  `

}

function computeDbAuthenticatorRoleSql (state) {
  const dbAuthenticatorRole = state.roleSet.dbAuthenticatorRole
  const dbUserRoles = state.roleSet.dbUserRoles
  return `
------------  DB AUTHENTICATOR ROLE ------------
DO
$body$
BEGIN
  IF NOT EXISTS (
    SELECT    *
    FROM   pg_catalog.pg_roles
    WHERE  rolname = '${dbAuthenticatorRole.roleName}')
  THEN
    CREATE ROLE ${dbAuthenticatorRole.roleName};
  END IF;

ALTER ROLE ${dbAuthenticatorRole.roleName} with LOGIN;
ALTER ROLE ${dbAuthenticatorRole.roleName} with NOINHERIT;

${dbUserRoles.map(ur => `GRANT ${ur.roleName} TO ${dbAuthenticatorRole.roleName};`).join('\n')}

END
$body$;
--||--
---------- END DB AUTHENTICATOR ROLE -----------
  `
}

function computeDbAnonymousRoleSql (state) {
  const dbAnonymousRole = state.roleSet.dbAnonymousRole
  return `
------------  DB ANONYMOUS ROLE ------------
DO
$body$
BEGIN
  IF NOT EXISTS (
    SELECT    *
    FROM   pg_catalog.pg_roles
    WHERE  rolname = '${dbAnonymousRole.roleName}')
  THEN
    CREATE ROLE ${dbAnonymousRole.roleName};
  END IF;

ALTER ROLE ${dbAnonymousRole.roleName} with NOLOGIN;

END
$body$;
--||--
---------- END DB ANONYMOUS ROLE -----------
  `
}

function computeDbUserRolesSql (state) {
  const dbUserRoles = state.roleSet.dbUserRoles.sort((a,b)=>{
    return a.applicableRoles.length - b.applicableRoles.length  
  })
  return `
---------- DB USER ROLES -----------
${dbUserRoles.map(ur => {
return `
    ------------ ${ur.roleName}
      DO
      $body$
      BEGIN
        IF NOT EXISTS (
          SELECT    *
          FROM   pg_catalog.pg_roles
          WHERE  rolname = '${ur.roleName}'
        ) THEN
          CREATE ROLE ${ur.roleName};
        END IF;

        ALTER ROLE ${ur.roleName} with NOLOGIN;
        ${ur.applicableRoles.map(ar => {
          return `
        GRANT ${ar.roleName} TO ${ur.roleName};`
        }).join('')}

      END
      $body$;
      --||--
    -------- END ${ur.roleName}
`
}).join('\n')}
---------- END USER ROLES ----------

`
}

function computeRolesSql (state) {
  return [
    `
----------
----------  BEGIN POSTGRES ROLES SQL
----------
    `,
    computeDbOwnerRoleSql(state),
    computeDbUserRolesSql(state),
    computeDbAuthenticatorRoleSql(state),
    `
----------
----------  END POSTGRES ROLES SQL
----------
--==
`
  ].join('\n')
}

export default computeRolesSql
