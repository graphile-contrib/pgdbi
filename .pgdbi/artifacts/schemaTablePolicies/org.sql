
----------
----------  BEGIN TABLE POLICY: org.organization
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.organization 
  from public;

  revoke all privileges 
  on table org.organization 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table org.organization disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table org.organization to app_visitor;
  --DENIED:   grant insert on table org.organization to app_visitor;
  --DENIED:   grant update on table org.organization to app_visitor;
  --DENIED:   grant delete on table org.organization to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table org.organization to app_anonymous;
  --DENIED:   grant insert on table org.organization to app_anonymous;
  --DENIED:   grant update on table org.organization to app_anonymous;
  --DENIED:   grant delete on table org.organization to app_anonymous;

----------  END TABLE POLICY: org.organization
--==
----------
----------  BEGIN TABLE POLICY: org.facility
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.facility 
  from public;

  revoke all privileges 
  on table org.facility 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table org.facility disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table org.facility to app_visitor;
  --DENIED:   grant insert on table org.facility to app_visitor;
  --DENIED:   grant update on table org.facility to app_visitor;
  --DENIED:   grant delete on table org.facility to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table org.facility to app_anonymous;
  --DENIED:   grant insert on table org.facility to app_anonymous;
  --DENIED:   grant update on table org.facility to app_anonymous;
  --DENIED:   grant delete on table org.facility to app_anonymous;

----------  END TABLE POLICY: org.facility
--==
----------
----------  BEGIN TABLE POLICY: org.config_org
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.config_org 
  from public;

  revoke all privileges 
  on table org.config_org 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table org.config_org disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table org.config_org to app_visitor;
  --DENIED:   grant insert on table org.config_org to app_visitor;
  --DENIED:   grant update on table org.config_org to app_visitor;
  --DENIED:   grant delete on table org.config_org to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table org.config_org to app_anonymous;
  --DENIED:   grant insert on table org.config_org to app_anonymous;
  --DENIED:   grant update on table org.config_org to app_anonymous;
  --DENIED:   grant delete on table org.config_org to app_anonymous;

----------  END TABLE POLICY: org.config_org
--==
----------
----------  BEGIN TABLE POLICY: org.contact
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.contact 
  from public;

  revoke all privileges 
  on table org.contact 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table org.contact disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table org.contact to app_visitor;
  --DENIED:   grant insert on table org.contact to app_visitor;
  --DENIED:   grant update on table org.contact to app_visitor;
  --DENIED:   grant delete on table org.contact to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table org.contact to app_anonymous;
  --DENIED:   grant insert on table org.contact to app_anonymous;
  --DENIED:   grant update on table org.contact to app_anonymous;
  --DENIED:   grant delete on table org.contact to app_anonymous;

----------  END TABLE POLICY: org.contact
--==
----------
----------  BEGIN TABLE POLICY: org.contact_app_user
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.contact_app_user 
  from public;

  revoke all privileges 
  on table org.contact_app_user 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table org.contact_app_user disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table org.contact_app_user to app_visitor;
  --DENIED:   grant insert on table org.contact_app_user to app_visitor;
  --DENIED:   grant update on table org.contact_app_user to app_visitor;
  --DENIED:   grant delete on table org.contact_app_user to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table org.contact_app_user to app_anonymous;
  --DENIED:   grant insert on table org.contact_app_user to app_anonymous;
  --DENIED:   grant update on table org.contact_app_user to app_anonymous;
  --DENIED:   grant delete on table org.contact_app_user to app_anonymous;

----------  END TABLE POLICY: org.contact_app_user
--==
----------
----------  BEGIN TABLE POLICY: org.location
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.location 
  from public;

  revoke all privileges 
  on table org.location 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table org.location disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table org.location to app_visitor;
  --DENIED:   grant insert on table org.location to app_visitor;
  --DENIED:   grant update on table org.location to app_visitor;
  --DENIED:   grant delete on table org.location to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table org.location to app_anonymous;
  --DENIED:   grant insert on table org.location to app_anonymous;
  --DENIED:   grant update on table org.location to app_anonymous;
  --DENIED:   grant delete on table org.location to app_anonymous;

----------  END TABLE POLICY: org.location
--==