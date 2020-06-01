
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

