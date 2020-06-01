
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

