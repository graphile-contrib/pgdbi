
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function app.fn_timestamp_update_application () to app_super_admin;
  --DENIED:   grant execute on function app.fn_timestamp_update_application () to app_admin;
  --DENIED:   grant execute on function app.fn_timestamp_update_application () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function app.fn_timestamp_update_license () to app_super_admin;
  --DENIED:   grant execute on function app.fn_timestamp_update_license () to app_admin;
  --DENIED:   grant execute on function app.fn_timestamp_update_license () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function app.fn_timestamp_update_license_permission () to app_super_admin;
  --DENIED:   grant execute on function app.fn_timestamp_update_license_permission () to app_admin;
  --DENIED:   grant execute on function app.fn_timestamp_update_license_permission () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function app.fn_timestamp_update_license_type () to app_super_admin;
  --DENIED:   grant execute on function app.fn_timestamp_update_license_type () to app_admin;
  --DENIED:   grant execute on function app.fn_timestamp_update_license_type () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function app.fn_timestamp_update_license_type_permission () to app_super_admin;
  --DENIED:   grant execute on function app.fn_timestamp_update_license_type_permission () to app_admin;
  --DENIED:   grant execute on function app.fn_timestamp_update_license_type_permission () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth.fn_timestamp_update_app_tenant () to app_super_admin;
  --DENIED:   grant execute on function auth.fn_timestamp_update_app_tenant () to app_admin;
  --DENIED:   grant execute on function auth.fn_timestamp_update_app_tenant () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth.fn_timestamp_update_app_user () to app_super_admin;
  --DENIED:   grant execute on function auth.fn_timestamp_update_app_user () to app_admin;
  --DENIED:   grant execute on function auth.fn_timestamp_update_app_user () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth.fn_timestamp_update_permission () to app_super_admin;
  --DENIED:   grant execute on function auth.fn_timestamp_update_permission () to app_admin;
  --DENIED:   grant execute on function auth.fn_timestamp_update_permission () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth_fn.app_user_has_access (text,text) to app_super_admin;
  --DENIED:   grant execute on function auth_fn.app_user_has_access (text,text) to app_admin;
  --DENIED:   grant execute on function auth_fn.app_user_has_access (text,text) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth_fn.authenticate (text,text) to app_super_admin;
  --DENIED:   grant execute on function auth_fn.authenticate (text,text) to app_admin;
  --DENIED:   grant execute on function auth_fn.authenticate (text,text) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth_fn.build_app_tenant (text,text) to app_super_admin;
  --DENIED:   grant execute on function auth_fn.build_app_tenant (text,text) to app_admin;
  --DENIED:   grant execute on function auth_fn.build_app_tenant (text,text) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth_fn.build_app_user (text,text,text,text,auth.permission_key) to app_super_admin;
  --DENIED:   grant execute on function auth_fn.build_app_user (text,text,text,text,auth.permission_key) to app_admin;
  --DENIED:   grant execute on function auth_fn.build_app_user (text,text,text,text,auth.permission_key) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth_fn.current_app_tenant_id () to app_super_admin;
  --DENIED:   grant execute on function auth_fn.current_app_tenant_id () to app_admin;
  --DENIED:   grant execute on function auth_fn.current_app_tenant_id () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth_fn.current_app_user () to app_super_admin;
  --DENIED:   grant execute on function auth_fn.current_app_user () to app_admin;
  --DENIED:   grant execute on function auth_fn.current_app_user () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function auth_fn.current_app_user_id () to app_super_admin;
  --DENIED:   grant execute on function auth_fn.current_app_user_id () to app_admin;
  --DENIED:   grant execute on function auth_fn.current_app_user_id () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_conversion () to app_super_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_conversion () to app_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_conversion () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_conversion_source () to app_super_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_conversion_source () to app_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_conversion_source () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_inventory_lot () to app_super_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_inventory_lot () to app_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_inventory_lot () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_lcb_license () to app_super_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_lcb_license () to app_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_lcb_license () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_lcb_license_holder () to app_super_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_lcb_license_holder () to app_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_lcb_license_holder () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_manifest () to app_super_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_manifest () to app_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_manifest () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_manifest_item () to app_super_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_manifest_item () to app_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_manifest_item () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb.fn_timestamp_update_recipe () to app_super_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_recipe () to app_admin;
  --DENIED:   grant execute on function lcb.fn_timestamp_update_recipe () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.convert_inventory (text,lcb_fn.convert_inventory_source_input[],lcb_fn.convert_inventory_result_input[]) to app_super_admin;
  --DENIED:   grant execute on function lcb_fn.convert_inventory (text,lcb_fn.convert_inventory_source_input[],lcb_fn.convert_inventory_result_input[]) to app_admin;
  --DENIED:   grant execute on function lcb_fn.convert_inventory (text,lcb_fn.convert_inventory_source_input[],lcb_fn.convert_inventory_result_input[]) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.create_xfer_manifest (text,timestamptz,text[]) to app_super_admin;
  --DENIED:   grant execute on function lcb_fn.create_xfer_manifest (text,timestamptz,text[]) to app_admin;
  --DENIED:   grant execute on function lcb_fn.create_xfer_manifest (text,timestamptz,text[]) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.deplete_inventory_lot_ids (text[]) to app_super_admin;
  --DENIED:   grant execute on function lcb_fn.deplete_inventory_lot_ids (text[]) to app_admin;
  --DENIED:   grant execute on function lcb_fn.deplete_inventory_lot_ids (text[]) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.destroy_inventory_lot_ids (text[]) to app_super_admin;
  --DENIED:   grant execute on function lcb_fn.destroy_inventory_lot_ids (text[]) to app_admin;
  --DENIED:   grant execute on function lcb_fn.destroy_inventory_lot_ids (text[]) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.get_currrent_lcb_license_holder_id () to app_super_admin;
  --DENIED:   grant execute on function lcb_fn.get_currrent_lcb_license_holder_id () to app_admin;
  --DENIED:   grant execute on function lcb_fn.get_currrent_lcb_license_holder_id () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.invalidate_inventory_lot_ids (text[]) to app_super_admin;
  --DENIED:   grant execute on function lcb_fn.invalidate_inventory_lot_ids (text[]) to app_admin;
  --DENIED:   grant execute on function lcb_fn.invalidate_inventory_lot_ids (text[]) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.provision_inventory_lot_ids (text,integer) to app_super_admin;
  --DENIED:   grant execute on function lcb_fn.provision_inventory_lot_ids (text,integer) to app_admin;
  --DENIED:   grant execute on function lcb_fn.provision_inventory_lot_ids (text,integer) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.qa_sample_inventory (text,lcb_fn.qa_sample_inventory_input[]) to app_super_admin;
  --DENIED:   grant execute on function lcb_fn.qa_sample_inventory (text,lcb_fn.qa_sample_inventory_input[]) to app_admin;
  --DENIED:   grant execute on function lcb_fn.qa_sample_inventory (text,lcb_fn.qa_sample_inventory_input[]) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.report_inventory_lot (lcb_fn.report_inventory_lot_input[]) to app_super_admin;
  --DENIED:   grant execute on function lcb_fn.report_inventory_lot (lcb_fn.report_inventory_lot_input[]) to app_admin;
  --DENIED:   grant execute on function lcb_fn.report_inventory_lot (lcb_fn.report_inventory_lot_input[]) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.rt_sample_inventory (text,lcb_fn.rt_sample_inventory_input[]) to app_super_admin;
  --DENIED:   grant execute on function lcb_fn.rt_sample_inventory (text,lcb_fn.rt_sample_inventory_input[]) to app_admin;
  --DENIED:   grant execute on function lcb_fn.rt_sample_inventory (text,lcb_fn.rt_sample_inventory_input[]) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.strain_inventory_type_lot_counts () to app_super_admin;
  --DENIED:   grant execute on function lcb_fn.strain_inventory_type_lot_counts () to app_admin;
  --DENIED:   grant execute on function lcb_fn.strain_inventory_type_lot_counts () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_fn.sublot_inventory (text,lcb_fn.sublot_inventory_input[]) to app_super_admin;
  --DENIED:   grant execute on function lcb_fn.sublot_inventory (text,lcb_fn.sublot_inventory_input[]) to app_admin;
  --DENIED:   grant execute on function lcb_fn.sublot_inventory (text,lcb_fn.sublot_inventory_input[]) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function lcb_hist.fn_capture_hist_inventory_lot () to app_super_admin;
  --DENIED:   grant execute on function lcb_hist.fn_capture_hist_inventory_lot () to app_admin;
  --DENIED:   grant execute on function lcb_hist.fn_capture_hist_inventory_lot () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org.fn_timestamp_update_contact () to app_super_admin;
  --DENIED:   grant execute on function org.fn_timestamp_update_contact () to app_admin;
  --DENIED:   grant execute on function org.fn_timestamp_update_contact () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org.fn_timestamp_update_contact_app_user () to app_super_admin;
  --DENIED:   grant execute on function org.fn_timestamp_update_contact_app_user () to app_admin;
  --DENIED:   grant execute on function org.fn_timestamp_update_contact_app_user () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org.fn_timestamp_update_facility () to app_super_admin;
  --DENIED:   grant execute on function org.fn_timestamp_update_facility () to app_admin;
  --DENIED:   grant execute on function org.fn_timestamp_update_facility () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org.fn_timestamp_update_location () to app_super_admin;
  --DENIED:   grant execute on function org.fn_timestamp_update_location () to app_admin;
  --DENIED:   grant execute on function org.fn_timestamp_update_location () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org.fn_timestamp_update_organization () to app_super_admin;
  --DENIED:   grant execute on function org.fn_timestamp_update_organization () to app_admin;
  --DENIED:   grant execute on function org.fn_timestamp_update_organization () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_contact (text,text,text,text,text,text,text,text,text) to app_super_admin;
  --DENIED:   grant execute on function org_fn.build_contact (text,text,text,text,text,text,text,text,text) to app_admin;
  --DENIED:   grant execute on function org_fn.build_contact (text,text,text,text,text,text,text,text,text) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_contact_location (text,text,text,text,text,text,text,text,text) to app_super_admin;
  --DENIED:   grant execute on function org_fn.build_contact_location (text,text,text,text,text,text,text,text,text) to app_admin;
  --DENIED:   grant execute on function org_fn.build_contact_location (text,text,text,text,text,text,text,text,text) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_facility (text,text,text) to app_super_admin;
  --DENIED:   grant execute on function org_fn.build_facility (text,text,text) to app_admin;
  --DENIED:   grant execute on function org_fn.build_facility (text,text,text) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_facility_location (text,text,text,text,text,text,text,text,text) to app_super_admin;
  --DENIED:   grant execute on function org_fn.build_facility_location (text,text,text,text,text,text,text,text,text) to app_admin;
  --DENIED:   grant execute on function org_fn.build_facility_location (text,text,text,text,text,text,text,text,text) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_location (text,text,text,text,text,text,text,text) to app_super_admin;
  --DENIED:   grant execute on function org_fn.build_location (text,text,text,text,text,text,text,text) to app_admin;
  --DENIED:   grant execute on function org_fn.build_location (text,text,text,text,text,text,text,text) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_organization (text,text) to app_super_admin;
  --DENIED:   grant execute on function org_fn.build_organization (text,text) to app_admin;
  --DENIED:   grant execute on function org_fn.build_organization (text,text) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_organization_location (text,text,text,text,text,text,text,text,text) to app_super_admin;
  --DENIED:   grant execute on function org_fn.build_organization_location (text,text,text,text,text,text,text,text,text) to app_admin;
  --DENIED:   grant execute on function org_fn.build_organization_location (text,text,text,text,text,text,text,text,text) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.build_tenant_organization (text,text,text,text,text) to app_super_admin;
  --DENIED:   grant execute on function org_fn.build_tenant_organization (text,text,text,text,text) to app_admin;
  --DENIED:   grant execute on function org_fn.build_tenant_organization (text,text,text,text,text) to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.current_app_user_contact () to app_super_admin;
  --DENIED:   grant execute on function org_fn.current_app_user_contact () to app_admin;
  --DENIED:   grant execute on function org_fn.current_app_user_contact () to app_user;
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
  from app_super_admin, app_admin, app_user, app_anonymous;

----------  CREATE NEW FUNCTION GRANTS
----------  IMPLIED FUNCTION GRANTS

  ----------  DENIED TABLE GRANTS
  --DENIED:   grant execute on function org_fn.modify_location (text,text,text,text,text,text,text,text,text) to app_super_admin;
  --DENIED:   grant execute on function org_fn.modify_location (text,text,text,text,text,text,text,text,text) to app_admin;
  --DENIED:   grant execute on function org_fn.modify_location (text,text,text,text,text,text,text,text,text) to app_user;
  --DENIED:   grant execute on function org_fn.modify_location (text,text,text,text,text,text,text,text,text) to app_anonymous;
----------  END FUNCTION POLICY: org_fn.modify_location (text,text,text,text,text,text,text,text,text)
--==

