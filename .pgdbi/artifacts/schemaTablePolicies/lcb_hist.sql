
----------
----------  BEGIN TABLE POLICY: lcb_hist.hist_inventory_lot
----------  POLICY NAME:  Default Table Policy - NO ACCESS
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table lcb_hist.hist_inventory_lot 
  from public;

  revoke all privileges 
  on table lcb_hist.hist_inventory_lot 
  from app_visitor, app_anonymous;

----------  DISABLE ROW LEVEL SECURITY

  alter table lcb_hist.hist_inventory_lot disable row level security;

----------  CREATE NEW TABLE GRANTS

----------  IMPLIED TABLE GRANTS

  ----------  DENIED TABLE GRANTS

  ----------  app_visitor
  --DENIED:   grant select on table lcb_hist.hist_inventory_lot to app_visitor;
  --DENIED:   grant insert on table lcb_hist.hist_inventory_lot to app_visitor;
  --DENIED:   grant update on table lcb_hist.hist_inventory_lot to app_visitor;
  --DENIED:   grant delete on table lcb_hist.hist_inventory_lot to app_visitor;

  ----------  app_anonymous
  --DENIED:   grant select on table lcb_hist.hist_inventory_lot to app_anonymous;
  --DENIED:   grant insert on table lcb_hist.hist_inventory_lot to app_anonymous;
  --DENIED:   grant update on table lcb_hist.hist_inventory_lot to app_anonymous;
  --DENIED:   grant delete on table lcb_hist.hist_inventory_lot to app_anonymous;

----------  END TABLE POLICY: lcb_hist.hist_inventory_lot
--==