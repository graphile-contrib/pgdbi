
----------
----------  BEGIN TABLE POLICY: app.license
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table app.license 
  from public;

  revoke all privileges 
  on table app.license 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table app.license disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table app.license to app_visitor;
  --DENIED:   grant insert on table app.license to app_visitor;
  --DENIED:   grant update on table app.license to app_visitor;
  --DENIED:   grant delete on table app.license to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table app.license to app_anonymous;
  --DENIED:   grant insert on table app.license to app_anonymous;
  --DENIED:   grant update on table app.license to app_anonymous;
  --DENIED:   grant delete on table app.license to app_anonymous;

----------  END TABLE POLICY: app.license
--==
----------
----------  BEGIN TABLE POLICY: app.license_type
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table app.license_type 
  from public;

  revoke all privileges 
  on table app.license_type 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table app.license_type disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table app.license_type to app_visitor;
  --DENIED:   grant insert on table app.license_type to app_visitor;
  --DENIED:   grant update on table app.license_type to app_visitor;
  --DENIED:   grant delete on table app.license_type to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table app.license_type to app_anonymous;
  --DENIED:   grant insert on table app.license_type to app_anonymous;
  --DENIED:   grant update on table app.license_type to app_anonymous;
  --DENIED:   grant delete on table app.license_type to app_anonymous;

----------  END TABLE POLICY: app.license_type
--==
----------
----------  BEGIN TABLE POLICY: app.license_permission
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table app.license_permission 
  from public;

  revoke all privileges 
  on table app.license_permission 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table app.license_permission disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table app.license_permission to app_visitor;
  --DENIED:   grant insert on table app.license_permission to app_visitor;
  --DENIED:   grant update on table app.license_permission to app_visitor;
  --DENIED:   grant delete on table app.license_permission to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table app.license_permission to app_anonymous;
  --DENIED:   grant insert on table app.license_permission to app_anonymous;
  --DENIED:   grant update on table app.license_permission to app_anonymous;
  --DENIED:   grant delete on table app.license_permission to app_anonymous;

----------  END TABLE POLICY: app.license_permission
--==
----------
----------  BEGIN TABLE POLICY: app.license_type_permission
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table app.license_type_permission 
  from public;

  revoke all privileges 
  on table app.license_type_permission 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table app.license_type_permission disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table app.license_type_permission to app_visitor;
  --DENIED:   grant insert on table app.license_type_permission to app_visitor;
  --DENIED:   grant update on table app.license_type_permission to app_visitor;
  --DENIED:   grant delete on table app.license_type_permission to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table app.license_type_permission to app_anonymous;
  --DENIED:   grant insert on table app.license_type_permission to app_anonymous;
  --DENIED:   grant update on table app.license_type_permission to app_anonymous;
  --DENIED:   grant delete on table app.license_type_permission to app_anonymous;

----------  END TABLE POLICY: app.license_type_permission
--==
----------
----------  BEGIN TABLE POLICY: app.application
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table app.application 
  from public;

  revoke all privileges 
  on table app.application 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table app.application disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table app.application to app_visitor;
  --DENIED:   grant insert on table app.application to app_visitor;
  --DENIED:   grant update on table app.application to app_visitor;
  --DENIED:   grant delete on table app.application to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table app.application to app_anonymous;
  --DENIED:   grant insert on table app.application to app_anonymous;
  --DENIED:   grant update on table app.application to app_anonymous;
  --DENIED:   grant delete on table app.application to app_anonymous;

----------  END TABLE POLICY: app.application
--==