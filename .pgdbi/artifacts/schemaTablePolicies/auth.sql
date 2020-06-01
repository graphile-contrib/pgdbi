
----------
----------  BEGIN TABLE POLICY: auth.config_auth
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table auth.config_auth 
  from public;

  revoke all privileges 
  on table auth.config_auth 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table auth.config_auth disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table auth.config_auth to app_visitor;
  --DENIED:   grant insert on table auth.config_auth to app_visitor;
  --DENIED:   grant update on table auth.config_auth to app_visitor;
  --DENIED:   grant delete on table auth.config_auth to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table auth.config_auth to app_anonymous;
  --DENIED:   grant insert on table auth.config_auth to app_anonymous;
  --DENIED:   grant update on table auth.config_auth to app_anonymous;
  --DENIED:   grant delete on table auth.config_auth to app_anonymous;

----------  END TABLE POLICY: auth.config_auth
--==
----------
----------  BEGIN TABLE POLICY: auth.token
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table auth.token 
  from public;

  revoke all privileges 
  on table auth.token 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table auth.token disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table auth.token to app_visitor;
  --DENIED:   grant insert on table auth.token to app_visitor;
  --DENIED:   grant update on table auth.token to app_visitor;
  --DENIED:   grant delete on table auth.token to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table auth.token to app_anonymous;
  --DENIED:   grant insert on table auth.token to app_anonymous;
  --DENIED:   grant update on table auth.token to app_anonymous;
  --DENIED:   grant delete on table auth.token to app_anonymous;

----------  END TABLE POLICY: auth.token
--==
----------
----------  BEGIN TABLE POLICY: auth.permission
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table auth.permission 
  from public;

  revoke all privileges 
  on table auth.permission 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table auth.permission disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table auth.permission to app_visitor;
  --DENIED:   grant insert on table auth.permission to app_visitor;
  --DENIED:   grant update on table auth.permission to app_visitor;
  --DENIED:   grant delete on table auth.permission to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table auth.permission to app_anonymous;
  --DENIED:   grant insert on table auth.permission to app_anonymous;
  --DENIED:   grant update on table auth.permission to app_anonymous;
  --DENIED:   grant delete on table auth.permission to app_anonymous;

----------  END TABLE POLICY: auth.permission
--==
----------
----------  BEGIN TABLE POLICY: auth.app_user
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table auth.app_user 
  from public;

  revoke all privileges 
  on table auth.app_user 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table auth.app_user disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table auth.app_user to app_visitor;
  --DENIED:   grant insert on table auth.app_user to app_visitor;
  --DENIED:   grant update on table auth.app_user to app_visitor;
  --DENIED:   grant delete on table auth.app_user to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table auth.app_user to app_anonymous;
  --DENIED:   grant insert on table auth.app_user to app_anonymous;
  --DENIED:   grant update on table auth.app_user to app_anonymous;
  --DENIED:   grant delete on table auth.app_user to app_anonymous;

----------  END TABLE POLICY: auth.app_user
--==
----------
----------  BEGIN TABLE POLICY: auth.app_tenant
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table auth.app_tenant 
  from public;

  revoke all privileges 
  on table auth.app_tenant 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table auth.app_tenant disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table auth.app_tenant to app_visitor;
  --DENIED:   grant insert on table auth.app_tenant to app_visitor;
  --DENIED:   grant update on table auth.app_tenant to app_visitor;
  --DENIED:   grant delete on table auth.app_tenant to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table auth.app_tenant to app_anonymous;
  --DENIED:   grant insert on table auth.app_tenant to app_anonymous;
  --DENIED:   grant update on table auth.app_tenant to app_anonymous;
  --DENIED:   grant delete on table auth.app_tenant to app_anonymous;

----------  END TABLE POLICY: auth.app_tenant
--==