
----------
----------  BEGIN OWNERSHIP SQL
----------

----------  SCHEMA: app
  ALTER SCHEMA app OWNER TO app_owner;
  -- tables
    ALTER TABLE app.license OWNER TO app_owner;
    ALTER TABLE app.license_type OWNER TO app_owner;
    ALTER TABLE app.license_type_permission OWNER TO app_owner;
    ALTER TABLE app.application OWNER TO app_owner;
    ALTER TABLE app.license_permission OWNER TO app_owner;
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
    ALTER TABLE auth.app_user OWNER TO app_owner;
    ALTER TABLE auth.app_tenant OWNER TO app_owner;
    ALTER TABLE auth.permission OWNER TO app_owner;
    ALTER TABLE auth.token OWNER TO app_owner;
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
    ALTER TABLE lcb.lcb_license_holder OWNER TO app_owner;
    ALTER TABLE lcb.area OWNER TO app_owner;
    ALTER TABLE lcb.batch OWNER TO app_owner;
    ALTER TABLE lcb.strain OWNER TO app_owner;
    ALTER TABLE lcb.lcb_license OWNER TO app_owner;
    ALTER TABLE lcb.conversion OWNER TO app_owner;
    ALTER TABLE lcb.recipe OWNER TO app_owner;
    ALTER TABLE lcb.conversion_source OWNER TO app_owner;
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
    ALTER TABLE lcb_ref.conversion_rule_source OWNER TO app_owner;
    ALTER TABLE lcb_ref.manifest_status OWNER TO app_owner;
    ALTER TABLE lcb_ref.inventory_lot_reporting_status OWNER TO app_owner;
    ALTER TABLE lcb_ref.inventory_type OWNER TO app_owner;
    ALTER TABLE lcb_ref.lcb_license_type OWNER TO app_owner;
    ALTER TABLE lcb_ref.conversion_rule OWNER TO app_owner;
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
