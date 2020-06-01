
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