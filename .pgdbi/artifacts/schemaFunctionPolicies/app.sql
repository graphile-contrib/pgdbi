
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

