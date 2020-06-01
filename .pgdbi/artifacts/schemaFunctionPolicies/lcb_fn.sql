
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

