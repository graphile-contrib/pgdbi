
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

