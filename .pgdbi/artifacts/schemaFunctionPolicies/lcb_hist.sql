
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

