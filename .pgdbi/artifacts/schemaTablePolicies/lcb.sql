
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