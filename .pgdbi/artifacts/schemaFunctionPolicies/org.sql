
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

