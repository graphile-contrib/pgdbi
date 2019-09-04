
----------
----------  BEGIN TABLE POLICY: org.organization
----------  POLICY NAME:  Custom Policy: org.organization
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.organization 
  from public;

  revoke all privileges 
  on table org.organization 
  from app_super_admin, app_tenant_admin, app_admin, app_user, app_demon, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table org.organization disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  app_super_admin
  grant 
    delete  
  on table org.organization 
  to app_super_admin;


----------  app_admin
  grant 
    update ( id, app_tenant_id, actual_app_tenant_id, created_at, updated_at, external_id, name, location_id, primary_contact_id ) 
        -- no excluded columns
  on table org.organization 
  to app_admin;


----------  app_user
  grant 
    select  
  on table org.organization 
  to app_user;



----------  END TABLE POLICY: org.organization
--==