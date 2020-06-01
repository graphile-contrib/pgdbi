
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
----------
----------  BEGIN TABLE POLICY: lcb.inventory_lot
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb.inventory_lot 
  from public;

  revoke all privileges 
  on table lcb.inventory_lot 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb.inventory_lot disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb.inventory_lot to app_visitor;
  --DENIED:   grant insert on table lcb.inventory_lot to app_visitor;
  --DENIED:   grant update on table lcb.inventory_lot to app_visitor;
  --DENIED:   grant delete on table lcb.inventory_lot to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb.inventory_lot to app_anonymous;
  --DENIED:   grant insert on table lcb.inventory_lot to app_anonymous;
  --DENIED:   grant update on table lcb.inventory_lot to app_anonymous;
  --DENIED:   grant delete on table lcb.inventory_lot to app_anonymous;

----------  END TABLE POLICY: lcb.inventory_lot
--==
----------
----------  BEGIN TABLE POLICY: lcb.batch
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb.batch 
  from public;

  revoke all privileges 
  on table lcb.batch 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb.batch disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb.batch to app_visitor;
  --DENIED:   grant insert on table lcb.batch to app_visitor;
  --DENIED:   grant update on table lcb.batch to app_visitor;
  --DENIED:   grant delete on table lcb.batch to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb.batch to app_anonymous;
  --DENIED:   grant insert on table lcb.batch to app_anonymous;
  --DENIED:   grant update on table lcb.batch to app_anonymous;
  --DENIED:   grant delete on table lcb.batch to app_anonymous;

----------  END TABLE POLICY: lcb.batch
--==
----------
----------  BEGIN TABLE POLICY: lcb.strain
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb.strain 
  from public;

  revoke all privileges 
  on table lcb.strain 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb.strain disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb.strain to app_visitor;
  --DENIED:   grant insert on table lcb.strain to app_visitor;
  --DENIED:   grant update on table lcb.strain to app_visitor;
  --DENIED:   grant delete on table lcb.strain to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb.strain to app_anonymous;
  --DENIED:   grant insert on table lcb.strain to app_anonymous;
  --DENIED:   grant update on table lcb.strain to app_anonymous;
  --DENIED:   grant delete on table lcb.strain to app_anonymous;

----------  END TABLE POLICY: lcb.strain
--==
----------
----------  BEGIN TABLE POLICY: lcb.lcb_license
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb.lcb_license 
  from public;

  revoke all privileges 
  on table lcb.lcb_license 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb.lcb_license disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb.lcb_license to app_visitor;
  --DENIED:   grant insert on table lcb.lcb_license to app_visitor;
  --DENIED:   grant update on table lcb.lcb_license to app_visitor;
  --DENIED:   grant delete on table lcb.lcb_license to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb.lcb_license to app_anonymous;
  --DENIED:   grant insert on table lcb.lcb_license to app_anonymous;
  --DENIED:   grant update on table lcb.lcb_license to app_anonymous;
  --DENIED:   grant delete on table lcb.lcb_license to app_anonymous;

----------  END TABLE POLICY: lcb.lcb_license
--==
----------
----------  BEGIN TABLE POLICY: lcb.conversion
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb.conversion 
  from public;

  revoke all privileges 
  on table lcb.conversion 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb.conversion disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb.conversion to app_visitor;
  --DENIED:   grant insert on table lcb.conversion to app_visitor;
  --DENIED:   grant update on table lcb.conversion to app_visitor;
  --DENIED:   grant delete on table lcb.conversion to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb.conversion to app_anonymous;
  --DENIED:   grant insert on table lcb.conversion to app_anonymous;
  --DENIED:   grant update on table lcb.conversion to app_anonymous;
  --DENIED:   grant delete on table lcb.conversion to app_anonymous;

----------  END TABLE POLICY: lcb.conversion
--==
----------
----------  BEGIN TABLE POLICY: lcb.recipe
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb.recipe 
  from public;

  revoke all privileges 
  on table lcb.recipe 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb.recipe disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb.recipe to app_visitor;
  --DENIED:   grant insert on table lcb.recipe to app_visitor;
  --DENIED:   grant update on table lcb.recipe to app_visitor;
  --DENIED:   grant delete on table lcb.recipe to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb.recipe to app_anonymous;
  --DENIED:   grant insert on table lcb.recipe to app_anonymous;
  --DENIED:   grant update on table lcb.recipe to app_anonymous;
  --DENIED:   grant delete on table lcb.recipe to app_anonymous;

----------  END TABLE POLICY: lcb.recipe
--==
----------
----------  BEGIN TABLE POLICY: lcb.conversion_source
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb.conversion_source 
  from public;

  revoke all privileges 
  on table lcb.conversion_source 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb.conversion_source disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb.conversion_source to app_visitor;
  --DENIED:   grant insert on table lcb.conversion_source to app_visitor;
  --DENIED:   grant update on table lcb.conversion_source to app_visitor;
  --DENIED:   grant delete on table lcb.conversion_source to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb.conversion_source to app_anonymous;
  --DENIED:   grant insert on table lcb.conversion_source to app_anonymous;
  --DENIED:   grant update on table lcb.conversion_source to app_anonymous;
  --DENIED:   grant delete on table lcb.conversion_source to app_anonymous;

----------  END TABLE POLICY: lcb.conversion_source
--==
----------
----------  BEGIN TABLE POLICY: lcb.lcb_license_holder
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb.lcb_license_holder 
  from public;

  revoke all privileges 
  on table lcb.lcb_license_holder 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb.lcb_license_holder disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb.lcb_license_holder to app_visitor;
  --DENIED:   grant insert on table lcb.lcb_license_holder to app_visitor;
  --DENIED:   grant update on table lcb.lcb_license_holder to app_visitor;
  --DENIED:   grant delete on table lcb.lcb_license_holder to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb.lcb_license_holder to app_anonymous;
  --DENIED:   grant insert on table lcb.lcb_license_holder to app_anonymous;
  --DENIED:   grant update on table lcb.lcb_license_holder to app_anonymous;
  --DENIED:   grant delete on table lcb.lcb_license_holder to app_anonymous;

----------  END TABLE POLICY: lcb.lcb_license_holder
--==
----------
----------  BEGIN TABLE POLICY: lcb.area
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb.area 
  from public;

  revoke all privileges 
  on table lcb.area 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb.area disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb.area to app_visitor;
  --DENIED:   grant insert on table lcb.area to app_visitor;
  --DENIED:   grant update on table lcb.area to app_visitor;
  --DENIED:   grant delete on table lcb.area to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb.area to app_anonymous;
  --DENIED:   grant insert on table lcb.area to app_anonymous;
  --DENIED:   grant update on table lcb.area to app_anonymous;
  --DENIED:   grant delete on table lcb.area to app_anonymous;

----------  END TABLE POLICY: lcb.area
--==
----------
----------  BEGIN TABLE POLICY: lcb.manifest_item
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb.manifest_item 
  from public;

  revoke all privileges 
  on table lcb.manifest_item 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb.manifest_item disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb.manifest_item to app_visitor;
  --DENIED:   grant insert on table lcb.manifest_item to app_visitor;
  --DENIED:   grant update on table lcb.manifest_item to app_visitor;
  --DENIED:   grant delete on table lcb.manifest_item to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb.manifest_item to app_anonymous;
  --DENIED:   grant insert on table lcb.manifest_item to app_anonymous;
  --DENIED:   grant update on table lcb.manifest_item to app_anonymous;
  --DENIED:   grant delete on table lcb.manifest_item to app_anonymous;

----------  END TABLE POLICY: lcb.manifest_item
--==
----------
----------  BEGIN TABLE POLICY: lcb.manifest
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb.manifest 
  from public;

  revoke all privileges 
  on table lcb.manifest 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb.manifest disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb.manifest to app_visitor;
  --DENIED:   grant insert on table lcb.manifest to app_visitor;
  --DENIED:   grant update on table lcb.manifest to app_visitor;
  --DENIED:   grant delete on table lcb.manifest to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb.manifest to app_anonymous;
  --DENIED:   grant insert on table lcb.manifest to app_anonymous;
  --DENIED:   grant update on table lcb.manifest to app_anonymous;
  --DENIED:   grant delete on table lcb.manifest to app_anonymous;

----------  END TABLE POLICY: lcb.manifest
--==
----------
----------  BEGIN TABLE POLICY: lcb.qa_result
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb.qa_result 
  from public;

  revoke all privileges 
  on table lcb.qa_result 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb.qa_result disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb.qa_result to app_visitor;
  --DENIED:   grant insert on table lcb.qa_result to app_visitor;
  --DENIED:   grant update on table lcb.qa_result to app_visitor;
  --DENIED:   grant delete on table lcb.qa_result to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb.qa_result to app_anonymous;
  --DENIED:   grant insert on table lcb.qa_result to app_anonymous;
  --DENIED:   grant update on table lcb.qa_result to app_anonymous;
  --DENIED:   grant delete on table lcb.qa_result to app_anonymous;

----------  END TABLE POLICY: lcb.qa_result
--==
----------
----------  BEGIN TABLE POLICY: lcb_hist.hist_inventory_lot
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb_hist.hist_inventory_lot 
  from public;

  revoke all privileges 
  on table lcb_hist.hist_inventory_lot 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb_hist.hist_inventory_lot disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb_hist.hist_inventory_lot to app_visitor;
  --DENIED:   grant insert on table lcb_hist.hist_inventory_lot to app_visitor;
  --DENIED:   grant update on table lcb_hist.hist_inventory_lot to app_visitor;
  --DENIED:   grant delete on table lcb_hist.hist_inventory_lot to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb_hist.hist_inventory_lot to app_anonymous;
  --DENIED:   grant insert on table lcb_hist.hist_inventory_lot to app_anonymous;
  --DENIED:   grant update on table lcb_hist.hist_inventory_lot to app_anonymous;
  --DENIED:   grant delete on table lcb_hist.hist_inventory_lot to app_anonymous;

----------  END TABLE POLICY: lcb_hist.hist_inventory_lot
--==
----------
----------  BEGIN TABLE POLICY: lcb_ref.lcb_license_type
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb_ref.lcb_license_type 
  from public;

  revoke all privileges 
  on table lcb_ref.lcb_license_type 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb_ref.lcb_license_type disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb_ref.lcb_license_type to app_visitor;
  --DENIED:   grant insert on table lcb_ref.lcb_license_type to app_visitor;
  --DENIED:   grant update on table lcb_ref.lcb_license_type to app_visitor;
  --DENIED:   grant delete on table lcb_ref.lcb_license_type to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb_ref.lcb_license_type to app_anonymous;
  --DENIED:   grant insert on table lcb_ref.lcb_license_type to app_anonymous;
  --DENIED:   grant update on table lcb_ref.lcb_license_type to app_anonymous;
  --DENIED:   grant delete on table lcb_ref.lcb_license_type to app_anonymous;

----------  END TABLE POLICY: lcb_ref.lcb_license_type
--==
----------
----------  BEGIN TABLE POLICY: lcb_ref.conversion_rule
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb_ref.conversion_rule 
  from public;

  revoke all privileges 
  on table lcb_ref.conversion_rule 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb_ref.conversion_rule disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb_ref.conversion_rule to app_visitor;
  --DENIED:   grant insert on table lcb_ref.conversion_rule to app_visitor;
  --DENIED:   grant update on table lcb_ref.conversion_rule to app_visitor;
  --DENIED:   grant delete on table lcb_ref.conversion_rule to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb_ref.conversion_rule to app_anonymous;
  --DENIED:   grant insert on table lcb_ref.conversion_rule to app_anonymous;
  --DENIED:   grant update on table lcb_ref.conversion_rule to app_anonymous;
  --DENIED:   grant delete on table lcb_ref.conversion_rule to app_anonymous;

----------  END TABLE POLICY: lcb_ref.conversion_rule
--==
----------
----------  BEGIN TABLE POLICY: lcb_ref.conversion_rule_source
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb_ref.conversion_rule_source 
  from public;

  revoke all privileges 
  on table lcb_ref.conversion_rule_source 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb_ref.conversion_rule_source disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb_ref.conversion_rule_source to app_visitor;
  --DENIED:   grant insert on table lcb_ref.conversion_rule_source to app_visitor;
  --DENIED:   grant update on table lcb_ref.conversion_rule_source to app_visitor;
  --DENIED:   grant delete on table lcb_ref.conversion_rule_source to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb_ref.conversion_rule_source to app_anonymous;
  --DENIED:   grant insert on table lcb_ref.conversion_rule_source to app_anonymous;
  --DENIED:   grant update on table lcb_ref.conversion_rule_source to app_anonymous;
  --DENIED:   grant delete on table lcb_ref.conversion_rule_source to app_anonymous;

----------  END TABLE POLICY: lcb_ref.conversion_rule_source
--==
----------
----------  BEGIN TABLE POLICY: lcb_ref.manifest_status
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb_ref.manifest_status 
  from public;

  revoke all privileges 
  on table lcb_ref.manifest_status 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb_ref.manifest_status disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb_ref.manifest_status to app_visitor;
  --DENIED:   grant insert on table lcb_ref.manifest_status to app_visitor;
  --DENIED:   grant update on table lcb_ref.manifest_status to app_visitor;
  --DENIED:   grant delete on table lcb_ref.manifest_status to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb_ref.manifest_status to app_anonymous;
  --DENIED:   grant insert on table lcb_ref.manifest_status to app_anonymous;
  --DENIED:   grant update on table lcb_ref.manifest_status to app_anonymous;
  --DENIED:   grant delete on table lcb_ref.manifest_status to app_anonymous;

----------  END TABLE POLICY: lcb_ref.manifest_status
--==
----------
----------  BEGIN TABLE POLICY: lcb_ref.inventory_lot_reporting_status
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb_ref.inventory_lot_reporting_status 
  from public;

  revoke all privileges 
  on table lcb_ref.inventory_lot_reporting_status 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb_ref.inventory_lot_reporting_status disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb_ref.inventory_lot_reporting_status to app_visitor;
  --DENIED:   grant insert on table lcb_ref.inventory_lot_reporting_status to app_visitor;
  --DENIED:   grant update on table lcb_ref.inventory_lot_reporting_status to app_visitor;
  --DENIED:   grant delete on table lcb_ref.inventory_lot_reporting_status to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb_ref.inventory_lot_reporting_status to app_anonymous;
  --DENIED:   grant insert on table lcb_ref.inventory_lot_reporting_status to app_anonymous;
  --DENIED:   grant update on table lcb_ref.inventory_lot_reporting_status to app_anonymous;
  --DENIED:   grant delete on table lcb_ref.inventory_lot_reporting_status to app_anonymous;

----------  END TABLE POLICY: lcb_ref.inventory_lot_reporting_status
--==
----------
----------  BEGIN TABLE POLICY: lcb_ref.inventory_type
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb_ref.inventory_type 
  from public;

  revoke all privileges 
  on table lcb_ref.inventory_type 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb_ref.inventory_type disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb_ref.inventory_type to app_visitor;
  --DENIED:   grant insert on table lcb_ref.inventory_type to app_visitor;
  --DENIED:   grant update on table lcb_ref.inventory_type to app_visitor;
  --DENIED:   grant delete on table lcb_ref.inventory_type to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb_ref.inventory_type to app_anonymous;
  --DENIED:   grant insert on table lcb_ref.inventory_type to app_anonymous;
  --DENIED:   grant update on table lcb_ref.inventory_type to app_anonymous;
  --DENIED:   grant delete on table lcb_ref.inventory_type to app_anonymous;

----------  END TABLE POLICY: lcb_ref.inventory_type
--==
----------
----------  BEGIN TABLE POLICY: lcb_ref.lcb_license_holder_status
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb_ref.lcb_license_holder_status 
  from public;

  revoke all privileges 
  on table lcb_ref.lcb_license_holder_status 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb_ref.lcb_license_holder_status disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb_ref.lcb_license_holder_status to app_visitor;
  --DENIED:   grant insert on table lcb_ref.lcb_license_holder_status to app_visitor;
  --DENIED:   grant update on table lcb_ref.lcb_license_holder_status to app_visitor;
  --DENIED:   grant delete on table lcb_ref.lcb_license_holder_status to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb_ref.lcb_license_holder_status to app_anonymous;
  --DENIED:   grant insert on table lcb_ref.lcb_license_holder_status to app_anonymous;
  --DENIED:   grant update on table lcb_ref.lcb_license_holder_status to app_anonymous;
  --DENIED:   grant delete on table lcb_ref.lcb_license_holder_status to app_anonymous;

----------  END TABLE POLICY: lcb_ref.lcb_license_holder_status
--==
----------
----------  BEGIN TABLE POLICY: lcb_ref.inventory_lot_type
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb_ref.inventory_lot_type 
  from public;

  revoke all privileges 
  on table lcb_ref.inventory_lot_type 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb_ref.inventory_lot_type disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb_ref.inventory_lot_type to app_visitor;
  --DENIED:   grant insert on table lcb_ref.inventory_lot_type to app_visitor;
  --DENIED:   grant update on table lcb_ref.inventory_lot_type to app_visitor;
  --DENIED:   grant delete on table lcb_ref.inventory_lot_type to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb_ref.inventory_lot_type to app_anonymous;
  --DENIED:   grant insert on table lcb_ref.inventory_lot_type to app_anonymous;
  --DENIED:   grant update on table lcb_ref.inventory_lot_type to app_anonymous;
  --DENIED:   grant delete on table lcb_ref.inventory_lot_type to app_anonymous;

----------  END TABLE POLICY: lcb_ref.inventory_lot_type
--==
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