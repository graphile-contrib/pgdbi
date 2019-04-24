
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  BEGIN: org.company
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  POLICY NAME:  Custom Policy: org.company
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  REMOVE EXISTING TABLE GRANTS
  
    revoke all privileges on table org.company from public;
    revoke all privileges on table org.company from app_super_admin;
    revoke all privileges on table org.company from app_admin;
    revoke all privileges on table org.company from app_user;
    revoke all privileges on table org.company from app_anonymous;
    revoke all privileges on table org.company from app_demon;

  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  ENABLE ROW LEVEL SECURITY
  
    alter table org.company enable row level security;
  
    create policy rls_special_app_admin_policy_that_will_make_things_confusing_org_company 
      on org.company
      as permissive
      for insert
      to app_admin
      using ( owner_id = viewer_id() )
      ;
    create policy rls_is_the_best_s_org_company 
      on org.company
      as permissive
      for all
      to app_user
      using ( owner_id = this-can-change-in-settings.viewer_id() )
      with check something_special
      ;
    create policy rls_something_else_org_company 
      on org.company
      as restrictive
      for all
      to app_user
      using (another_function())
      ;
  
  
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  CREATE NEW TABLE GRANTS

  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  app_super_admin
    grant 
      delete  
    on table org.company 
    to app_super_admin;


  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  app_user
    grant 
      select , 
      insert ( id, external_id, licenses, company_type, name, updated_at, location_id ), -- excluded columns: created_at
      update ( external_id, licenses, company_type, name, updated_at, location_id ), -- excluded columns: id, created_at
    on table org.company 
    to app_user;

  
  
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  END: org.company
  --==
   