
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

