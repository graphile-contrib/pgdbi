--=====  BEGIN COMPLETE SECURITY POLICY -========

----------
----------  BEGIN POSTGRES ROLES SQL
----------
    

------------  DB OWNER ROLE ------------
DO
$body$
BEGIN
  IF NOT EXISTS (
    SELECT    *
    FROM   pg_catalog.pg_roles
    WHERE  rolname = 'app_owner')
  THEN
    CREATE ROLE app_owner;
  END IF;

  ALTER ROLE app_owner with LOGIN;
  ALTER ROLE app_owner with CREATEDB;

END
$body$;
--||--
---------- END DB OWNER ROLE -----------
  

---------- DB USER ROLES -----------

    ------------ app_anonymous
      DO
      $body$
      BEGIN
        IF NOT EXISTS (
          SELECT    *
          FROM   pg_catalog.pg_roles
          WHERE  rolname = 'app_anonymous'
        ) THEN
          CREATE ROLE app_anonymous;
        END IF;

        ALTER ROLE app_anonymous with NOLOGIN;
        

      END
      $body$;
      --||--
    -------- END app_anonymous


    ------------ app_visitor
      DO
      $body$
      BEGIN
        IF NOT EXISTS (
          SELECT    *
          FROM   pg_catalog.pg_roles
          WHERE  rolname = 'app_visitor'
        ) THEN
          CREATE ROLE app_visitor;
        END IF;

        ALTER ROLE app_visitor with NOLOGIN;
        
        GRANT app_anonymous TO app_visitor;

      END
      $body$;
      --||--
    -------- END app_visitor

---------- END USER ROLES ----------



------------  DB AUTHENTICATOR ROLE ------------
DO
$body$
BEGIN
  IF NOT EXISTS (
    SELECT    *
    FROM   pg_catalog.pg_roles
    WHERE  rolname = 'app_authenticator')
  THEN
    CREATE ROLE app_authenticator;
  END IF;

ALTER ROLE app_authenticator with LOGIN;
ALTER ROLE app_authenticator with NOINHERIT;

GRANT app_anonymous TO app_authenticator;
GRANT app_visitor TO app_authenticator;

END
$body$;
--||--
---------- END DB AUTHENTICATOR ROLE -----------
  

----------
----------  END POSTGRES ROLES SQL
----------
--==



--*****  BEGIN OWNERSHIP -********

----------
----------  BEGIN OWNERSHIP SQL
----------

----------  SCHEMA: app
  ALTER SCHEMA app OWNER TO app_owner;
  -- tables
    ALTER TABLE app.license OWNER TO app_owner;
    ALTER TABLE app.license_type OWNER TO app_owner;
    ALTER TABLE app.license_permission OWNER TO app_owner;
    ALTER TABLE app.license_type_permission OWNER TO app_owner;
    ALTER TABLE app.application OWNER TO app_owner;
  -- functions
    ALTER FUNCTION app.fn_timestamp_update_application() OWNER TO app_owner;
    ALTER FUNCTION app.fn_timestamp_update_license() OWNER TO app_owner;
    ALTER FUNCTION app.fn_timestamp_update_license_permission() OWNER TO app_owner;
    ALTER FUNCTION app.fn_timestamp_update_license_type() OWNER TO app_owner;
    ALTER FUNCTION app.fn_timestamp_update_license_type_permission() OWNER TO app_owner;
----------  END SCHEMA: app
----------  SCHEMA: auth
  ALTER SCHEMA auth OWNER TO app_owner;
  -- tables
    ALTER TABLE auth.config_auth OWNER TO app_owner;
    ALTER TABLE auth.token OWNER TO app_owner;
    ALTER TABLE auth.permission OWNER TO app_owner;
    ALTER TABLE auth.app_user OWNER TO app_owner;
    ALTER TABLE auth.app_tenant OWNER TO app_owner;
  -- functions
    ALTER FUNCTION auth.fn_timestamp_update_app_tenant() OWNER TO app_owner;
    ALTER FUNCTION auth.fn_timestamp_update_app_user() OWNER TO app_owner;
    ALTER FUNCTION auth.fn_timestamp_update_permission() OWNER TO app_owner;
----------  END SCHEMA: auth
----------  SCHEMA: auth_fn
  ALTER SCHEMA auth_fn OWNER TO app_owner;
  -- tables
  -- functions
    ALTER FUNCTION auth_fn.app_user_has_access(text, text) OWNER TO app_owner;
    ALTER FUNCTION auth_fn.authenticate(text, text) OWNER TO app_owner;
    ALTER FUNCTION auth_fn.build_app_tenant(text, text) OWNER TO app_owner;
    ALTER FUNCTION auth_fn.build_app_user(text, text, text, text, auth.permission_key) OWNER TO app_owner;
    ALTER FUNCTION auth_fn.current_app_tenant_id() OWNER TO app_owner;
    ALTER FUNCTION auth_fn.current_app_user() OWNER TO app_owner;
    ALTER FUNCTION auth_fn.current_app_user_id() OWNER TO app_owner;
----------  END SCHEMA: auth_fn
----------  SCHEMA: lcb
  ALTER SCHEMA lcb OWNER TO app_owner;
  -- tables
    ALTER TABLE lcb.inventory_lot OWNER TO app_owner;
    ALTER TABLE lcb.batch OWNER TO app_owner;
    ALTER TABLE lcb.strain OWNER TO app_owner;
    ALTER TABLE lcb.lcb_license OWNER TO app_owner;
    ALTER TABLE lcb.conversion OWNER TO app_owner;
    ALTER TABLE lcb.recipe OWNER TO app_owner;
    ALTER TABLE lcb.conversion_source OWNER TO app_owner;
    ALTER TABLE lcb.lcb_license_holder OWNER TO app_owner;
    ALTER TABLE lcb.area OWNER TO app_owner;
    ALTER TABLE lcb.manifest_item OWNER TO app_owner;
    ALTER TABLE lcb.manifest OWNER TO app_owner;
    ALTER TABLE lcb.qa_result OWNER TO app_owner;
  -- functions
    ALTER FUNCTION lcb.fn_timestamp_update_conversion() OWNER TO app_owner;
    ALTER FUNCTION lcb.fn_timestamp_update_conversion_source() OWNER TO app_owner;
    ALTER FUNCTION lcb.fn_timestamp_update_inventory_lot() OWNER TO app_owner;
    ALTER FUNCTION lcb.fn_timestamp_update_lcb_license() OWNER TO app_owner;
    ALTER FUNCTION lcb.fn_timestamp_update_lcb_license_holder() OWNER TO app_owner;
    ALTER FUNCTION lcb.fn_timestamp_update_manifest() OWNER TO app_owner;
    ALTER FUNCTION lcb.fn_timestamp_update_manifest_item() OWNER TO app_owner;
    ALTER FUNCTION lcb.fn_timestamp_update_recipe() OWNER TO app_owner;
----------  END SCHEMA: lcb
----------  SCHEMA: lcb_fn
  ALTER SCHEMA lcb_fn OWNER TO app_owner;
  -- tables
  -- functions
    ALTER FUNCTION lcb_fn.convert_inventory(text, lcb_fn.convert_inventory_source_input[], lcb_fn.convert_inventory_result_input[]) OWNER TO app_owner;
    ALTER FUNCTION lcb_fn.create_xfer_manifest(text, timestamptz, text[]) OWNER TO app_owner;
    ALTER FUNCTION lcb_fn.deplete_inventory_lot_ids(text[]) OWNER TO app_owner;
    ALTER FUNCTION lcb_fn.destroy_inventory_lot_ids(text[]) OWNER TO app_owner;
    ALTER FUNCTION lcb_fn.get_currrent_lcb_license_holder_id() OWNER TO app_owner;
    ALTER FUNCTION lcb_fn.invalidate_inventory_lot_ids(text[]) OWNER TO app_owner;
    ALTER FUNCTION lcb_fn.provision_inventory_lot_ids(text, integer) OWNER TO app_owner;
    ALTER FUNCTION lcb_fn.qa_sample_inventory(text, lcb_fn.qa_sample_inventory_input[]) OWNER TO app_owner;
    ALTER FUNCTION lcb_fn.report_inventory_lot(lcb_fn.report_inventory_lot_input[]) OWNER TO app_owner;
    ALTER FUNCTION lcb_fn.rt_sample_inventory(text, lcb_fn.rt_sample_inventory_input[]) OWNER TO app_owner;
    ALTER FUNCTION lcb_fn.strain_inventory_type_lot_counts() OWNER TO app_owner;
    ALTER FUNCTION lcb_fn.sublot_inventory(text, lcb_fn.sublot_inventory_input[]) OWNER TO app_owner;
----------  END SCHEMA: lcb_fn
----------  SCHEMA: lcb_hist
  ALTER SCHEMA lcb_hist OWNER TO app_owner;
  -- tables
    ALTER TABLE lcb_hist.hist_inventory_lot OWNER TO app_owner;
  -- functions
    ALTER FUNCTION lcb_hist.fn_capture_hist_inventory_lot() OWNER TO app_owner;
----------  END SCHEMA: lcb_hist
----------  SCHEMA: lcb_ref
  ALTER SCHEMA lcb_ref OWNER TO app_owner;
  -- tables
    ALTER TABLE lcb_ref.lcb_license_type OWNER TO app_owner;
    ALTER TABLE lcb_ref.conversion_rule OWNER TO app_owner;
    ALTER TABLE lcb_ref.conversion_rule_source OWNER TO app_owner;
    ALTER TABLE lcb_ref.manifest_status OWNER TO app_owner;
    ALTER TABLE lcb_ref.inventory_lot_reporting_status OWNER TO app_owner;
    ALTER TABLE lcb_ref.inventory_type OWNER TO app_owner;
    ALTER TABLE lcb_ref.lcb_license_holder_status OWNER TO app_owner;
    ALTER TABLE lcb_ref.inventory_lot_type OWNER TO app_owner;
  -- functions
----------  END SCHEMA: lcb_ref
----------  SCHEMA: org
  ALTER SCHEMA org OWNER TO app_owner;
  -- tables
    ALTER TABLE org.organization OWNER TO app_owner;
    ALTER TABLE org.facility OWNER TO app_owner;
    ALTER TABLE org.config_org OWNER TO app_owner;
    ALTER TABLE org.contact OWNER TO app_owner;
    ALTER TABLE org.contact_app_user OWNER TO app_owner;
    ALTER TABLE org.location OWNER TO app_owner;
  -- functions
    ALTER FUNCTION org.fn_timestamp_update_contact() OWNER TO app_owner;
    ALTER FUNCTION org.fn_timestamp_update_contact_app_user() OWNER TO app_owner;
    ALTER FUNCTION org.fn_timestamp_update_facility() OWNER TO app_owner;
    ALTER FUNCTION org.fn_timestamp_update_location() OWNER TO app_owner;
    ALTER FUNCTION org.fn_timestamp_update_organization() OWNER TO app_owner;
----------  END SCHEMA: org
----------  SCHEMA: org_fn
  ALTER SCHEMA org_fn OWNER TO app_owner;
  -- tables
  -- functions
    ALTER FUNCTION org_fn.build_contact(text, text, text, text, text, text, text, text, text) OWNER TO app_owner;
    ALTER FUNCTION org_fn.build_contact_location(text, text, text, text, text, text, text, text, text) OWNER TO app_owner;
    ALTER FUNCTION org_fn.build_facility(text, text, text) OWNER TO app_owner;
    ALTER FUNCTION org_fn.build_facility_location(text, text, text, text, text, text, text, text, text) OWNER TO app_owner;
    ALTER FUNCTION org_fn.build_location(text, text, text, text, text, text, text, text) OWNER TO app_owner;
    ALTER FUNCTION org_fn.build_organization(text, text) OWNER TO app_owner;
    ALTER FUNCTION org_fn.build_organization_location(text, text, text, text, text, text, text, text, text) OWNER TO app_owner;
    ALTER FUNCTION org_fn.build_tenant_organization(text, text, text, text, text) OWNER TO app_owner;
    ALTER FUNCTION org_fn.current_app_user_contact() OWNER TO app_owner;
    ALTER FUNCTION org_fn.modify_location(text, text, text, text, text, text, text, text, text) OWNER TO app_owner;
----------  END SCHEMA: org_fn
----------
----------  END OWNERSHIP SQL
----------
--==

--*****  END OWNERSHIP -**********


--*****  BEGIN SCHEMA USAGE -********

----------
----------  BEGIN SCHEMA USAGE SQL
----------

REVOKE USAGE ON SCHEMA public FROM PUBLIC;

GRANT USAGE ON SCHEMA public TO app_authenticator;

------- app
  REVOKE USAGE ON SCHEMA app FROM PUBLIC;
  REVOKE USAGE ON SCHEMA app FROM app_authenticator;
  REVOKE USAGE ON SCHEMA app FROM app_anonymous;
  REVOKE USAGE ON SCHEMA app FROM app_visitor;

------- auth
  REVOKE USAGE ON SCHEMA auth FROM PUBLIC;
  REVOKE USAGE ON SCHEMA auth FROM app_authenticator;
  REVOKE USAGE ON SCHEMA auth FROM app_anonymous;
  REVOKE USAGE ON SCHEMA auth FROM app_visitor;

------- auth_fn
  REVOKE USAGE ON SCHEMA auth_fn FROM PUBLIC;
  REVOKE USAGE ON SCHEMA auth_fn FROM app_authenticator;
  REVOKE USAGE ON SCHEMA auth_fn FROM app_anonymous;
  REVOKE USAGE ON SCHEMA auth_fn FROM app_visitor;

------- lcb
  REVOKE USAGE ON SCHEMA lcb FROM PUBLIC;
  REVOKE USAGE ON SCHEMA lcb FROM app_authenticator;
  REVOKE USAGE ON SCHEMA lcb FROM app_anonymous;
  REVOKE USAGE ON SCHEMA lcb FROM app_visitor;

------- lcb_fn
  REVOKE USAGE ON SCHEMA lcb_fn FROM PUBLIC;
  REVOKE USAGE ON SCHEMA lcb_fn FROM app_authenticator;
  REVOKE USAGE ON SCHEMA lcb_fn FROM app_anonymous;
  REVOKE USAGE ON SCHEMA lcb_fn FROM app_visitor;

------- lcb_hist
  REVOKE USAGE ON SCHEMA lcb_hist FROM PUBLIC;
  REVOKE USAGE ON SCHEMA lcb_hist FROM app_authenticator;
  REVOKE USAGE ON SCHEMA lcb_hist FROM app_anonymous;
  REVOKE USAGE ON SCHEMA lcb_hist FROM app_visitor;

------- lcb_ref
  REVOKE USAGE ON SCHEMA lcb_ref FROM PUBLIC;
  REVOKE USAGE ON SCHEMA lcb_ref FROM app_authenticator;
  REVOKE USAGE ON SCHEMA lcb_ref FROM app_anonymous;
  REVOKE USAGE ON SCHEMA lcb_ref FROM app_visitor;

------- org
  REVOKE USAGE ON SCHEMA org FROM PUBLIC;
  REVOKE USAGE ON SCHEMA org FROM app_authenticator;
  REVOKE USAGE ON SCHEMA org FROM app_anonymous;
  REVOKE USAGE ON SCHEMA org FROM app_visitor;

------- org_fn
  REVOKE USAGE ON SCHEMA org_fn FROM PUBLIC;
  REVOKE USAGE ON SCHEMA org_fn FROM app_authenticator;
  REVOKE USAGE ON SCHEMA org_fn FROM app_anonymous;
  REVOKE USAGE ON SCHEMA org_fn FROM app_visitor;

----------
----------  END SCHEMA USAGE SQL
----------
--==

--*****  END SCHEMA USAGE -**********


--*****  BEGIN TABLE POLICIES -********

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
--*****  END TABLE POLICIES -**********


--*****  BEGIN FUNCTION POLICIES -********

----------
----------  BEGIN FUNCTION POLICY: app.fn_timestamp_update_application ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function app.fn_timestamp_update_application () 
  from public;

  revoke all privileges 
  on function app.fn_timestamp_update_application () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function app.fn_timestamp_update_application () to app_visitor;
  --DENIED:   grant execute on function app.fn_timestamp_update_application () to app_anonymous;
----------  END FUNCTION POLICY: app.fn_timestamp_update_application ()
--==


----------
----------  BEGIN FUNCTION POLICY: app.fn_timestamp_update_license ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function app.fn_timestamp_update_license () 
  from public;

  revoke all privileges 
  on function app.fn_timestamp_update_license () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function app.fn_timestamp_update_license () to app_visitor;
  --DENIED:   grant execute on function app.fn_timestamp_update_license () to app_anonymous;
----------  END FUNCTION POLICY: app.fn_timestamp_update_license ()
--==


----------
----------  BEGIN FUNCTION POLICY: app.fn_timestamp_update_license_permission ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function app.fn_timestamp_update_license_permission () 
  from public;

  revoke all privileges 
  on function app.fn_timestamp_update_license_permission () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function app.fn_timestamp_update_license_permission () to app_visitor;
  --DENIED:   grant execute on function app.fn_timestamp_update_license_permission () to app_anonymous;
----------  END FUNCTION POLICY: app.fn_timestamp_update_license_permission ()
--==


----------
----------  BEGIN FUNCTION POLICY: app.fn_timestamp_update_license_type ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function app.fn_timestamp_update_license_type () 
  from public;

  revoke all privileges 
  on function app.fn_timestamp_update_license_type () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function app.fn_timestamp_update_license_type () to app_visitor;
  --DENIED:   grant execute on function app.fn_timestamp_update_license_type () to app_anonymous;
----------  END FUNCTION POLICY: app.fn_timestamp_update_license_type ()
--==


----------
----------  BEGIN FUNCTION POLICY: app.fn_timestamp_update_license_type_permission ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function app.fn_timestamp_update_license_type_permission () 
  from public;

  revoke all privileges 
  on function app.fn_timestamp_update_license_type_permission () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function app.fn_timestamp_update_license_type_permission () to app_visitor;
  --DENIED:   grant execute on function app.fn_timestamp_update_license_type_permission () to app_anonymous;
----------  END FUNCTION POLICY: app.fn_timestamp_update_license_type_permission ()
--==


----------
----------  BEGIN FUNCTION POLICY: auth.fn_timestamp_update_app_tenant ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function auth.fn_timestamp_update_app_tenant () 
  from public;

  revoke all privileges 
  on function auth.fn_timestamp_update_app_tenant () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth.fn_timestamp_update_app_tenant () to app_visitor;
  --DENIED:   grant execute on function auth.fn_timestamp_update_app_tenant () to app_anonymous;
----------  END FUNCTION POLICY: auth.fn_timestamp_update_app_tenant ()
--==


----------
----------  BEGIN FUNCTION POLICY: auth.fn_timestamp_update_app_user ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function auth.fn_timestamp_update_app_user () 
  from public;

  revoke all privileges 
  on function auth.fn_timestamp_update_app_user () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth.fn_timestamp_update_app_user () to app_visitor;
  --DENIED:   grant execute on function auth.fn_timestamp_update_app_user () to app_anonymous;
----------  END FUNCTION POLICY: auth.fn_timestamp_update_app_user ()
--==


----------
----------  BEGIN FUNCTION POLICY: auth.fn_timestamp_update_permission ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function auth.fn_timestamp_update_permission () 
  from public;

  revoke all privileges 
  on function auth.fn_timestamp_update_permission () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth.fn_timestamp_update_permission () to app_visitor;
  --DENIED:   grant execute on function auth.fn_timestamp_update_permission () to app_anonymous;
----------  END FUNCTION POLICY: auth.fn_timestamp_update_permission ()
--==


----------
----------  BEGIN FUNCTION POLICY: auth_fn.app_user_has_access (text,text)
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function auth_fn.app_user_has_access (text,text) 
  from public;

  revoke all privileges 
  on function auth_fn.app_user_has_access (text,text) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth_fn.app_user_has_access (text,text) to app_visitor;
  --DENIED:   grant execute on function auth_fn.app_user_has_access (text,text) to app_anonymous;
----------  END FUNCTION POLICY: auth_fn.app_user_has_access (text,text)
--==


----------
----------  BEGIN FUNCTION POLICY: auth_fn.authenticate (text,text)
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function auth_fn.authenticate (text,text) 
  from public;

  revoke all privileges 
  on function auth_fn.authenticate (text,text) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth_fn.authenticate (text,text) to app_visitor;
  --DENIED:   grant execute on function auth_fn.authenticate (text,text) to app_anonymous;
----------  END FUNCTION POLICY: auth_fn.authenticate (text,text)
--==


----------
----------  BEGIN FUNCTION POLICY: auth_fn.build_app_tenant (text,text)
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function auth_fn.build_app_tenant (text,text) 
  from public;

  revoke all privileges 
  on function auth_fn.build_app_tenant (text,text) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth_fn.build_app_tenant (text,text) to app_visitor;
  --DENIED:   grant execute on function auth_fn.build_app_tenant (text,text) to app_anonymous;
----------  END FUNCTION POLICY: auth_fn.build_app_tenant (text,text)
--==


----------
----------  BEGIN FUNCTION POLICY: auth_fn.build_app_user (text,text,text,text,auth.permission_key)
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function auth_fn.build_app_user (text,text,text,text,auth.permission_key) 
  from public;

  revoke all privileges 
  on function auth_fn.build_app_user (text,text,text,text,auth.permission_key) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth_fn.build_app_user (text,text,text,text,auth.permission_key) to app_visitor;
  --DENIED:   grant execute on function auth_fn.build_app_user (text,text,text,text,auth.permission_key) to app_anonymous;
----------  END FUNCTION POLICY: auth_fn.build_app_user (text,text,text,text,auth.permission_key)
--==


----------
----------  BEGIN FUNCTION POLICY: auth_fn.current_app_tenant_id ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function auth_fn.current_app_tenant_id () 
  from public;

  revoke all privileges 
  on function auth_fn.current_app_tenant_id () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth_fn.current_app_tenant_id () to app_visitor;
  --DENIED:   grant execute on function auth_fn.current_app_tenant_id () to app_anonymous;
----------  END FUNCTION POLICY: auth_fn.current_app_tenant_id ()
--==


----------
----------  BEGIN FUNCTION POLICY: auth_fn.current_app_user ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function auth_fn.current_app_user () 
  from public;

  revoke all privileges 
  on function auth_fn.current_app_user () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth_fn.current_app_user () to app_visitor;
  --DENIED:   grant execute on function auth_fn.current_app_user () to app_anonymous;
----------  END FUNCTION POLICY: auth_fn.current_app_user ()
--==


----------
----------  BEGIN FUNCTION POLICY: auth_fn.current_app_user_id ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function auth_fn.current_app_user_id () 
  from public;

  revoke all privileges 
  on function auth_fn.current_app_user_id () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth_fn.current_app_user_id () to app_visitor;
  --DENIED:   grant execute on function auth_fn.current_app_user_id () to app_anonymous;
----------  END FUNCTION POLICY: auth_fn.current_app_user_id ()
--==


----------
----------  BEGIN FUNCTION POLICY: lcb.fn_timestamp_update_conversion ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb.fn_timestamp_update_conversion () 
  from public;

  revoke all privileges 
  on function lcb.fn_timestamp_update_conversion () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_conversion () to app_visitor;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_conversion () to app_anonymous;
----------  END FUNCTION POLICY: lcb.fn_timestamp_update_conversion ()
--==


----------
----------  BEGIN FUNCTION POLICY: lcb.fn_timestamp_update_conversion_source ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb.fn_timestamp_update_conversion_source () 
  from public;

  revoke all privileges 
  on function lcb.fn_timestamp_update_conversion_source () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_conversion_source () to app_visitor;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_conversion_source () to app_anonymous;
----------  END FUNCTION POLICY: lcb.fn_timestamp_update_conversion_source ()
--==


----------
----------  BEGIN FUNCTION POLICY: lcb.fn_timestamp_update_inventory_lot ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb.fn_timestamp_update_inventory_lot () 
  from public;

  revoke all privileges 
  on function lcb.fn_timestamp_update_inventory_lot () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_inventory_lot () to app_visitor;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_inventory_lot () to app_anonymous;
----------  END FUNCTION POLICY: lcb.fn_timestamp_update_inventory_lot ()
--==


----------
----------  BEGIN FUNCTION POLICY: lcb.fn_timestamp_update_lcb_license ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb.fn_timestamp_update_lcb_license () 
  from public;

  revoke all privileges 
  on function lcb.fn_timestamp_update_lcb_license () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_lcb_license () to app_visitor;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_lcb_license () to app_anonymous;
----------  END FUNCTION POLICY: lcb.fn_timestamp_update_lcb_license ()
--==


----------
----------  BEGIN FUNCTION POLICY: lcb.fn_timestamp_update_lcb_license_holder ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb.fn_timestamp_update_lcb_license_holder () 
  from public;

  revoke all privileges 
  on function lcb.fn_timestamp_update_lcb_license_holder () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_lcb_license_holder () to app_visitor;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_lcb_license_holder () to app_anonymous;
----------  END FUNCTION POLICY: lcb.fn_timestamp_update_lcb_license_holder ()
--==


----------
----------  BEGIN FUNCTION POLICY: lcb.fn_timestamp_update_manifest ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb.fn_timestamp_update_manifest () 
  from public;

  revoke all privileges 
  on function lcb.fn_timestamp_update_manifest () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_manifest () to app_visitor;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_manifest () to app_anonymous;
----------  END FUNCTION POLICY: lcb.fn_timestamp_update_manifest ()
--==


----------
----------  BEGIN FUNCTION POLICY: lcb.fn_timestamp_update_manifest_item ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb.fn_timestamp_update_manifest_item () 
  from public;

  revoke all privileges 
  on function lcb.fn_timestamp_update_manifest_item () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_manifest_item () to app_visitor;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_manifest_item () to app_anonymous;
----------  END FUNCTION POLICY: lcb.fn_timestamp_update_manifest_item ()
--==


----------
----------  BEGIN FUNCTION POLICY: lcb.fn_timestamp_update_recipe ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb.fn_timestamp_update_recipe () 
  from public;

  revoke all privileges 
  on function lcb.fn_timestamp_update_recipe () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_recipe () to app_visitor;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_recipe () to app_anonymous;
----------  END FUNCTION POLICY: lcb.fn_timestamp_update_recipe ()
--==


----------
----------  BEGIN FUNCTION POLICY: lcb_fn.convert_inventory (text,lcb_fn.convert_inventory_source_input[],lcb_fn.convert_inventory_result_input[])
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb_fn.convert_inventory (text,lcb_fn.convert_inventory_source_input[],lcb_fn.convert_inventory_result_input[]) 
  from public;

  revoke all privileges 
  on function lcb_fn.convert_inventory (text,lcb_fn.convert_inventory_source_input[],lcb_fn.convert_inventory_result_input[]) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.convert_inventory (text,lcb_fn.convert_inventory_source_input[],lcb_fn.convert_inventory_result_input[]) to app_visitor;
  --DENIED:   grant execute on function lcb_fn.convert_inventory (text,lcb_fn.convert_inventory_source_input[],lcb_fn.convert_inventory_result_input[]) to app_anonymous;
----------  END FUNCTION POLICY: lcb_fn.convert_inventory (text,lcb_fn.convert_inventory_source_input[],lcb_fn.convert_inventory_result_input[])
--==


----------
----------  BEGIN FUNCTION POLICY: lcb_fn.create_xfer_manifest (text,timestamptz,text[])
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb_fn.create_xfer_manifest (text,timestamptz,text[]) 
  from public;

  revoke all privileges 
  on function lcb_fn.create_xfer_manifest (text,timestamptz,text[]) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.create_xfer_manifest (text,timestamptz,text[]) to app_visitor;
  --DENIED:   grant execute on function lcb_fn.create_xfer_manifest (text,timestamptz,text[]) to app_anonymous;
----------  END FUNCTION POLICY: lcb_fn.create_xfer_manifest (text,timestamptz,text[])
--==


----------
----------  BEGIN FUNCTION POLICY: lcb_fn.deplete_inventory_lot_ids (text[])
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb_fn.deplete_inventory_lot_ids (text[]) 
  from public;

  revoke all privileges 
  on function lcb_fn.deplete_inventory_lot_ids (text[]) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.deplete_inventory_lot_ids (text[]) to app_visitor;
  --DENIED:   grant execute on function lcb_fn.deplete_inventory_lot_ids (text[]) to app_anonymous;
----------  END FUNCTION POLICY: lcb_fn.deplete_inventory_lot_ids (text[])
--==


----------
----------  BEGIN FUNCTION POLICY: lcb_fn.destroy_inventory_lot_ids (text[])
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb_fn.destroy_inventory_lot_ids (text[]) 
  from public;

  revoke all privileges 
  on function lcb_fn.destroy_inventory_lot_ids (text[]) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.destroy_inventory_lot_ids (text[]) to app_visitor;
  --DENIED:   grant execute on function lcb_fn.destroy_inventory_lot_ids (text[]) to app_anonymous;
----------  END FUNCTION POLICY: lcb_fn.destroy_inventory_lot_ids (text[])
--==


----------
----------  BEGIN FUNCTION POLICY: lcb_fn.get_currrent_lcb_license_holder_id ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb_fn.get_currrent_lcb_license_holder_id () 
  from public;

  revoke all privileges 
  on function lcb_fn.get_currrent_lcb_license_holder_id () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.get_currrent_lcb_license_holder_id () to app_visitor;
  --DENIED:   grant execute on function lcb_fn.get_currrent_lcb_license_holder_id () to app_anonymous;
----------  END FUNCTION POLICY: lcb_fn.get_currrent_lcb_license_holder_id ()
--==


----------
----------  BEGIN FUNCTION POLICY: lcb_fn.invalidate_inventory_lot_ids (text[])
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb_fn.invalidate_inventory_lot_ids (text[]) 
  from public;

  revoke all privileges 
  on function lcb_fn.invalidate_inventory_lot_ids (text[]) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.invalidate_inventory_lot_ids (text[]) to app_visitor;
  --DENIED:   grant execute on function lcb_fn.invalidate_inventory_lot_ids (text[]) to app_anonymous;
----------  END FUNCTION POLICY: lcb_fn.invalidate_inventory_lot_ids (text[])
--==


----------
----------  BEGIN FUNCTION POLICY: lcb_fn.provision_inventory_lot_ids (text,integer)
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb_fn.provision_inventory_lot_ids (text,integer) 
  from public;

  revoke all privileges 
  on function lcb_fn.provision_inventory_lot_ids (text,integer) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.provision_inventory_lot_ids (text,integer) to app_visitor;
  --DENIED:   grant execute on function lcb_fn.provision_inventory_lot_ids (text,integer) to app_anonymous;
----------  END FUNCTION POLICY: lcb_fn.provision_inventory_lot_ids (text,integer)
--==


----------
----------  BEGIN FUNCTION POLICY: lcb_fn.qa_sample_inventory (text,lcb_fn.qa_sample_inventory_input[])
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb_fn.qa_sample_inventory (text,lcb_fn.qa_sample_inventory_input[]) 
  from public;

  revoke all privileges 
  on function lcb_fn.qa_sample_inventory (text,lcb_fn.qa_sample_inventory_input[]) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.qa_sample_inventory (text,lcb_fn.qa_sample_inventory_input[]) to app_visitor;
  --DENIED:   grant execute on function lcb_fn.qa_sample_inventory (text,lcb_fn.qa_sample_inventory_input[]) to app_anonymous;
----------  END FUNCTION POLICY: lcb_fn.qa_sample_inventory (text,lcb_fn.qa_sample_inventory_input[])
--==


----------
----------  BEGIN FUNCTION POLICY: lcb_fn.report_inventory_lot (lcb_fn.report_inventory_lot_input[])
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb_fn.report_inventory_lot (lcb_fn.report_inventory_lot_input[]) 
  from public;

  revoke all privileges 
  on function lcb_fn.report_inventory_lot (lcb_fn.report_inventory_lot_input[]) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.report_inventory_lot (lcb_fn.report_inventory_lot_input[]) to app_visitor;
  --DENIED:   grant execute on function lcb_fn.report_inventory_lot (lcb_fn.report_inventory_lot_input[]) to app_anonymous;
----------  END FUNCTION POLICY: lcb_fn.report_inventory_lot (lcb_fn.report_inventory_lot_input[])
--==


----------
----------  BEGIN FUNCTION POLICY: lcb_fn.rt_sample_inventory (text,lcb_fn.rt_sample_inventory_input[])
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb_fn.rt_sample_inventory (text,lcb_fn.rt_sample_inventory_input[]) 
  from public;

  revoke all privileges 
  on function lcb_fn.rt_sample_inventory (text,lcb_fn.rt_sample_inventory_input[]) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.rt_sample_inventory (text,lcb_fn.rt_sample_inventory_input[]) to app_visitor;
  --DENIED:   grant execute on function lcb_fn.rt_sample_inventory (text,lcb_fn.rt_sample_inventory_input[]) to app_anonymous;
----------  END FUNCTION POLICY: lcb_fn.rt_sample_inventory (text,lcb_fn.rt_sample_inventory_input[])
--==


----------
----------  BEGIN FUNCTION POLICY: lcb_fn.strain_inventory_type_lot_counts ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb_fn.strain_inventory_type_lot_counts () 
  from public;

  revoke all privileges 
  on function lcb_fn.strain_inventory_type_lot_counts () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.strain_inventory_type_lot_counts () to app_visitor;
  --DENIED:   grant execute on function lcb_fn.strain_inventory_type_lot_counts () to app_anonymous;
----------  END FUNCTION POLICY: lcb_fn.strain_inventory_type_lot_counts ()
--==


----------
----------  BEGIN FUNCTION POLICY: lcb_fn.sublot_inventory (text,lcb_fn.sublot_inventory_input[])
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb_fn.sublot_inventory (text,lcb_fn.sublot_inventory_input[]) 
  from public;

  revoke all privileges 
  on function lcb_fn.sublot_inventory (text,lcb_fn.sublot_inventory_input[]) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.sublot_inventory (text,lcb_fn.sublot_inventory_input[]) to app_visitor;
  --DENIED:   grant execute on function lcb_fn.sublot_inventory (text,lcb_fn.sublot_inventory_input[]) to app_anonymous;
----------  END FUNCTION POLICY: lcb_fn.sublot_inventory (text,lcb_fn.sublot_inventory_input[])
--==


----------
----------  BEGIN FUNCTION POLICY: lcb_hist.fn_capture_hist_inventory_lot ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function lcb_hist.fn_capture_hist_inventory_lot () 
  from public;

  revoke all privileges 
  on function lcb_hist.fn_capture_hist_inventory_lot () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_hist.fn_capture_hist_inventory_lot () to app_visitor;
  --DENIED:   grant execute on function lcb_hist.fn_capture_hist_inventory_lot () to app_anonymous;
----------  END FUNCTION POLICY: lcb_hist.fn_capture_hist_inventory_lot ()
--==


----------
----------  BEGIN FUNCTION POLICY: org.fn_timestamp_update_contact ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function org.fn_timestamp_update_contact () 
  from public;

  revoke all privileges 
  on function org.fn_timestamp_update_contact () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org.fn_timestamp_update_contact () to app_visitor;
  --DENIED:   grant execute on function org.fn_timestamp_update_contact () to app_anonymous;
----------  END FUNCTION POLICY: org.fn_timestamp_update_contact ()
--==


----------
----------  BEGIN FUNCTION POLICY: org.fn_timestamp_update_contact_app_user ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function org.fn_timestamp_update_contact_app_user () 
  from public;

  revoke all privileges 
  on function org.fn_timestamp_update_contact_app_user () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org.fn_timestamp_update_contact_app_user () to app_visitor;
  --DENIED:   grant execute on function org.fn_timestamp_update_contact_app_user () to app_anonymous;
----------  END FUNCTION POLICY: org.fn_timestamp_update_contact_app_user ()
--==


----------
----------  BEGIN FUNCTION POLICY: org.fn_timestamp_update_facility ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function org.fn_timestamp_update_facility () 
  from public;

  revoke all privileges 
  on function org.fn_timestamp_update_facility () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org.fn_timestamp_update_facility () to app_visitor;
  --DENIED:   grant execute on function org.fn_timestamp_update_facility () to app_anonymous;
----------  END FUNCTION POLICY: org.fn_timestamp_update_facility ()
--==


----------
----------  BEGIN FUNCTION POLICY: org.fn_timestamp_update_location ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function org.fn_timestamp_update_location () 
  from public;

  revoke all privileges 
  on function org.fn_timestamp_update_location () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org.fn_timestamp_update_location () to app_visitor;
  --DENIED:   grant execute on function org.fn_timestamp_update_location () to app_anonymous;
----------  END FUNCTION POLICY: org.fn_timestamp_update_location ()
--==


----------
----------  BEGIN FUNCTION POLICY: org.fn_timestamp_update_organization ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function org.fn_timestamp_update_organization () 
  from public;

  revoke all privileges 
  on function org.fn_timestamp_update_organization () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org.fn_timestamp_update_organization () to app_visitor;
  --DENIED:   grant execute on function org.fn_timestamp_update_organization () to app_anonymous;
----------  END FUNCTION POLICY: org.fn_timestamp_update_organization ()
--==


----------
----------  BEGIN FUNCTION POLICY: org_fn.build_contact (text,text,text,text,text,text,text,text,text)
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function org_fn.build_contact (text,text,text,text,text,text,text,text,text) 
  from public;

  revoke all privileges 
  on function org_fn.build_contact (text,text,text,text,text,text,text,text,text) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_contact (text,text,text,text,text,text,text,text,text) to app_visitor;
  --DENIED:   grant execute on function org_fn.build_contact (text,text,text,text,text,text,text,text,text) to app_anonymous;
----------  END FUNCTION POLICY: org_fn.build_contact (text,text,text,text,text,text,text,text,text)
--==


----------
----------  BEGIN FUNCTION POLICY: org_fn.build_contact_location (text,text,text,text,text,text,text,text,text)
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function org_fn.build_contact_location (text,text,text,text,text,text,text,text,text) 
  from public;

  revoke all privileges 
  on function org_fn.build_contact_location (text,text,text,text,text,text,text,text,text) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_contact_location (text,text,text,text,text,text,text,text,text) to app_visitor;
  --DENIED:   grant execute on function org_fn.build_contact_location (text,text,text,text,text,text,text,text,text) to app_anonymous;
----------  END FUNCTION POLICY: org_fn.build_contact_location (text,text,text,text,text,text,text,text,text)
--==


----------
----------  BEGIN FUNCTION POLICY: org_fn.build_facility (text,text,text)
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function org_fn.build_facility (text,text,text) 
  from public;

  revoke all privileges 
  on function org_fn.build_facility (text,text,text) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_facility (text,text,text) to app_visitor;
  --DENIED:   grant execute on function org_fn.build_facility (text,text,text) to app_anonymous;
----------  END FUNCTION POLICY: org_fn.build_facility (text,text,text)
--==


----------
----------  BEGIN FUNCTION POLICY: org_fn.build_facility_location (text,text,text,text,text,text,text,text,text)
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function org_fn.build_facility_location (text,text,text,text,text,text,text,text,text) 
  from public;

  revoke all privileges 
  on function org_fn.build_facility_location (text,text,text,text,text,text,text,text,text) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_facility_location (text,text,text,text,text,text,text,text,text) to app_visitor;
  --DENIED:   grant execute on function org_fn.build_facility_location (text,text,text,text,text,text,text,text,text) to app_anonymous;
----------  END FUNCTION POLICY: org_fn.build_facility_location (text,text,text,text,text,text,text,text,text)
--==


----------
----------  BEGIN FUNCTION POLICY: org_fn.build_location (text,text,text,text,text,text,text,text)
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function org_fn.build_location (text,text,text,text,text,text,text,text) 
  from public;

  revoke all privileges 
  on function org_fn.build_location (text,text,text,text,text,text,text,text) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_location (text,text,text,text,text,text,text,text) to app_visitor;
  --DENIED:   grant execute on function org_fn.build_location (text,text,text,text,text,text,text,text) to app_anonymous;
----------  END FUNCTION POLICY: org_fn.build_location (text,text,text,text,text,text,text,text)
--==


----------
----------  BEGIN FUNCTION POLICY: org_fn.build_organization (text,text)
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function org_fn.build_organization (text,text) 
  from public;

  revoke all privileges 
  on function org_fn.build_organization (text,text) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_organization (text,text) to app_visitor;
  --DENIED:   grant execute on function org_fn.build_organization (text,text) to app_anonymous;
----------  END FUNCTION POLICY: org_fn.build_organization (text,text)
--==


----------
----------  BEGIN FUNCTION POLICY: org_fn.build_organization_location (text,text,text,text,text,text,text,text,text)
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function org_fn.build_organization_location (text,text,text,text,text,text,text,text,text) 
  from public;

  revoke all privileges 
  on function org_fn.build_organization_location (text,text,text,text,text,text,text,text,text) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_organization_location (text,text,text,text,text,text,text,text,text) to app_visitor;
  --DENIED:   grant execute on function org_fn.build_organization_location (text,text,text,text,text,text,text,text,text) to app_anonymous;
----------  END FUNCTION POLICY: org_fn.build_organization_location (text,text,text,text,text,text,text,text,text)
--==


----------
----------  BEGIN FUNCTION POLICY: org_fn.build_tenant_organization (text,text,text,text,text)
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function org_fn.build_tenant_organization (text,text,text,text,text) 
  from public;

  revoke all privileges 
  on function org_fn.build_tenant_organization (text,text,text,text,text) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_tenant_organization (text,text,text,text,text) to app_visitor;
  --DENIED:   grant execute on function org_fn.build_tenant_organization (text,text,text,text,text) to app_anonymous;
----------  END FUNCTION POLICY: org_fn.build_tenant_organization (text,text,text,text,text)
--==


----------
----------  BEGIN FUNCTION POLICY: org_fn.current_app_user_contact ()
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function org_fn.current_app_user_contact () 
  from public;

  revoke all privileges 
  on function org_fn.current_app_user_contact () 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.current_app_user_contact () to app_visitor;
  --DENIED:   grant execute on function org_fn.current_app_user_contact () to app_anonymous;
----------  END FUNCTION POLICY: org_fn.current_app_user_contact ()
--==


----------
----------  BEGIN FUNCTION POLICY: org_fn.modify_location (text,text,text,text,text,text,text,text,text)
----------  POLICY NAME:  Default Function Policy - NO ACCESS
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function org_fn.modify_location (text,text,text,text,text,text,text,text,text) 
  from public;

  revoke all privileges 
  on function org_fn.modify_location (text,text,text,text,text,text,text,text,text) 
  from app_visitor, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.modify_location (text,text,text,text,text,text,text,text,text) to app_visitor;
  --DENIED:   grant execute on function org_fn.modify_location (text,text,text,text,text,text,text,text,text) to app_anonymous;
----------  END FUNCTION POLICY: org_fn.modify_location (text,text,text,text,text,text,text,text,text)
--==


--*****  END FUNCTION POLICIES -**********


--=====  END COMPLETE SECURITY POLICY -==========