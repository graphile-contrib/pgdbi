
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  BEGIN: evt.evt
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  POLICY NAME:  Custom Policy: evt.evt
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  REMOVE EXISTING TABLE GRANTS
  
    revoke all privileges on table evt.evt from public;
    revoke all privileges on table evt.evt from app_super_admin;
    revoke all privileges on table evt.evt from app_admin;
    revoke all privileges on table evt.evt from app_user;
    revoke all privileges on table evt.evt from app_anonymous;
    revoke all privileges on table evt.evt from app_demon;
  
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  CREATE NEW TABLE GRANTS

  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  app_admin
    grant insert ( entity_id, seller_id, created_by_contact_id, created_at, name, params )
    on table evt.evt 
    to app_admin;
      -- excluded columns: id

    grant update ( entity_id, seller_id, created_by_contact_id, created_at, name, params )
    on table evt.evt 
    to app_admin;
      -- excluded columns: id

    grant delete {{grantColumns}}
    on table evt.evt 
    to app_admin;


  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  app_user
    grant select {{grantColumns}}
    on table evt.evt 
    to app_user;

    grant insert ( entity_id, seller_id, created_by_contact_id, name, params )
    on table evt.evt 
    to app_user;
      -- excluded columns: created_at, id

    grant update ( entity_id, seller_id, created_by_contact_id, name, params )
    on table evt.evt 
    to app_user;
      -- excluded columns: created_at, id

  
  
  
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  ENABLE ROW LEVEL SECURITY
  
    alter table evt.evt enable row level security;
  
    create policy rls_default_evt_evt 
      on evt.evt
      as permissive
      for all
      to app_user
      using ( owner_id = viewer_id() )
      ;
  
  
  
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------  END: evt.evt
  --==

   