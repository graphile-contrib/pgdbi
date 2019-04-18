
  --=================== BEGIN: mtrx.discrepancy_502 ===================

  --------------------------------------------------------------------------------------------------------------------------------------------------
  -----------------------------------------------------  POLICY NAME:  New Table Policy  -------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------------

  -------------------------------------------------------- REMOVE EXISTING TABLE GRANTS ----------------------
  
    revoke all privileges on table mtrx.discrepancy_502 from public;
    revoke all privileges on table mtrx.discrepancy_502 from soro_super_admin;
    revoke all privileges on table mtrx.discrepancy_502 from soro_admin;
    revoke all privileges on table mtrx.discrepancy_502 from soro_user;
    revoke all privileges on table mtrx.discrepancy_502 from soro_anonymous;
    revoke all privileges on table mtrx.discrepancy_502 from soro_sync;
  
  -------------------------------------------------------- CREATE NEW TABLE GRANTS ----------------------

  -------------------------------------------------------- soro_anonymous
    grant select on table mtrx.discrepancy_502 to soro_anonymous;
    grant insert on table mtrx.discrepancy_502 to soro_anonymous;
  
  
  
    -------------- DISABLE ROW LEVEL SECURITY ----------------------
  
    alter table mtrx.discrepancy_502 disable row level security;
  
  
  --===================== END: mtrx.discrepancy_502 ===================
  
  --=================== BEGIN: mtrx.report_reconciliation ===================

  --------------------------------------------------------------------------------------------------------------------------------------------------
  -----------------------------------------------------  POLICY NAME:  New Table Policy  -------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------------

  -------------------------------------------------------- REMOVE EXISTING TABLE GRANTS ----------------------
  
    revoke all privileges on table mtrx.report_reconciliation from public;
    revoke all privileges on table mtrx.report_reconciliation from soro_super_admin;
    revoke all privileges on table mtrx.report_reconciliation from soro_admin;
    revoke all privileges on table mtrx.report_reconciliation from soro_user;
    revoke all privileges on table mtrx.report_reconciliation from soro_anonymous;
    revoke all privileges on table mtrx.report_reconciliation from soro_sync;
  
  -------------------------------------------------------- CREATE NEW TABLE GRANTS ----------------------

  -------------------------------------------------------- soro_anonymous
    grant select on table mtrx.report_reconciliation to soro_anonymous;
    grant insert on table mtrx.report_reconciliation to soro_anonymous;
  
  
  
    -------------- DISABLE ROW LEVEL SECURITY ----------------------
  
    alter table mtrx.report_reconciliation disable row level security;
  
  
  --===================== END: mtrx.report_reconciliation ===================
  
  --=================== BEGIN: mtrx.resolution_502_leaf_transfer ===================

  --------------------------------------------------------------------------------------------------------------------------------------------------
  -----------------------------------------------------  POLICY NAME:  New Table Policy  -------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------------

  -------------------------------------------------------- REMOVE EXISTING TABLE GRANTS ----------------------
  
    revoke all privileges on table mtrx.resolution_502_leaf_transfer from public;
    revoke all privileges on table mtrx.resolution_502_leaf_transfer from soro_super_admin;
    revoke all privileges on table mtrx.resolution_502_leaf_transfer from soro_admin;
    revoke all privileges on table mtrx.resolution_502_leaf_transfer from soro_user;
    revoke all privileges on table mtrx.resolution_502_leaf_transfer from soro_anonymous;
    revoke all privileges on table mtrx.resolution_502_leaf_transfer from soro_sync;
  
  -------------------------------------------------------- CREATE NEW TABLE GRANTS ----------------------

  -------------------------------------------------------- soro_anonymous
    grant select on table mtrx.resolution_502_leaf_transfer to soro_anonymous;
    grant insert on table mtrx.resolution_502_leaf_transfer to soro_anonymous;
  
  
  
    -------------- DISABLE ROW LEVEL SECURITY ----------------------
  
    alter table mtrx.resolution_502_leaf_transfer disable row level security;
  
  
  --===================== END: mtrx.resolution_502_leaf_transfer ===================
  
  --=================== BEGIN: mtrx.resolution_502_leaf_transfer_item ===================

  --------------------------------------------------------------------------------------------------------------------------------------------------
  -----------------------------------------------------  POLICY NAME:  New Table Policy  -------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------------

  -------------------------------------------------------- REMOVE EXISTING TABLE GRANTS ----------------------
  
    revoke all privileges on table mtrx.resolution_502_leaf_transfer_item from public;
    revoke all privileges on table mtrx.resolution_502_leaf_transfer_item from soro_super_admin;
    revoke all privileges on table mtrx.resolution_502_leaf_transfer_item from soro_admin;
    revoke all privileges on table mtrx.resolution_502_leaf_transfer_item from soro_user;
    revoke all privileges on table mtrx.resolution_502_leaf_transfer_item from soro_anonymous;
    revoke all privileges on table mtrx.resolution_502_leaf_transfer_item from soro_sync;
  
  -------------------------------------------------------- CREATE NEW TABLE GRANTS ----------------------

  -------------------------------------------------------- soro_anonymous
    grant select on table mtrx.resolution_502_leaf_transfer_item to soro_anonymous;
    grant insert on table mtrx.resolution_502_leaf_transfer_item to soro_anonymous;
  
  
  
    -------------- DISABLE ROW LEVEL SECURITY ----------------------
  
    alter table mtrx.resolution_502_leaf_transfer_item disable row level security;
  
  
  --===================== END: mtrx.resolution_502_leaf_transfer_item ===================
  
  --=================== BEGIN: mtrx.resolution_502_order_info ===================

  --------------------------------------------------------------------------------------------------------------------------------------------------
  -----------------------------------------------------  POLICY NAME:  New Table Policy  -------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------------

  -------------------------------------------------------- REMOVE EXISTING TABLE GRANTS ----------------------
  
    revoke all privileges on table mtrx.resolution_502_order_info from public;
    revoke all privileges on table mtrx.resolution_502_order_info from soro_super_admin;
    revoke all privileges on table mtrx.resolution_502_order_info from soro_admin;
    revoke all privileges on table mtrx.resolution_502_order_info from soro_user;
    revoke all privileges on table mtrx.resolution_502_order_info from soro_anonymous;
    revoke all privileges on table mtrx.resolution_502_order_info from soro_sync;
  
  -------------------------------------------------------- CREATE NEW TABLE GRANTS ----------------------

  -------------------------------------------------------- soro_anonymous
    grant select on table mtrx.resolution_502_order_info to soro_anonymous;
    grant insert on table mtrx.resolution_502_order_info to soro_anonymous;
  
  
  
    -------------- DISABLE ROW LEVEL SECURITY ----------------------
  
    alter table mtrx.resolution_502_order_info disable row level security;
  
  
  --===================== END: mtrx.resolution_502_order_info ===================
  
  --=================== BEGIN: mtrx.resolution_502_ucs_manifest_stop ===================

  --------------------------------------------------------------------------------------------------------------------------------------------------
  -----------------------------------------------------  POLICY NAME:  New Table Policy  -------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------------

  -------------------------------------------------------- REMOVE EXISTING TABLE GRANTS ----------------------
  
    revoke all privileges on table mtrx.resolution_502_ucs_manifest_stop from public;
    revoke all privileges on table mtrx.resolution_502_ucs_manifest_stop from soro_super_admin;
    revoke all privileges on table mtrx.resolution_502_ucs_manifest_stop from soro_admin;
    revoke all privileges on table mtrx.resolution_502_ucs_manifest_stop from soro_user;
    revoke all privileges on table mtrx.resolution_502_ucs_manifest_stop from soro_anonymous;
    revoke all privileges on table mtrx.resolution_502_ucs_manifest_stop from soro_sync;
  
  -------------------------------------------------------- CREATE NEW TABLE GRANTS ----------------------

  -------------------------------------------------------- soro_anonymous
    grant select on table mtrx.resolution_502_ucs_manifest_stop to soro_anonymous;
    grant insert on table mtrx.resolution_502_ucs_manifest_stop to soro_anonymous;
  
  
  
    -------------- DISABLE ROW LEVEL SECURITY ----------------------
  
    alter table mtrx.resolution_502_ucs_manifest_stop disable row level security;
  
  
  --===================== END: mtrx.resolution_502_ucs_manifest_stop ===================
  
  --=================== BEGIN: mtrx.resolution_502_ucs_manifest_stop_item ===================

  --------------------------------------------------------------------------------------------------------------------------------------------------
  -----------------------------------------------------  POLICY NAME:  New Table Policy  -------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------------

  -------------------------------------------------------- REMOVE EXISTING TABLE GRANTS ----------------------
  
    revoke all privileges on table mtrx.resolution_502_ucs_manifest_stop_item from public;
    revoke all privileges on table mtrx.resolution_502_ucs_manifest_stop_item from soro_super_admin;
    revoke all privileges on table mtrx.resolution_502_ucs_manifest_stop_item from soro_admin;
    revoke all privileges on table mtrx.resolution_502_ucs_manifest_stop_item from soro_user;
    revoke all privileges on table mtrx.resolution_502_ucs_manifest_stop_item from soro_anonymous;
    revoke all privileges on table mtrx.resolution_502_ucs_manifest_stop_item from soro_sync;
  
  -------------------------------------------------------- CREATE NEW TABLE GRANTS ----------------------

  -------------------------------------------------------- soro_anonymous
    grant select on table mtrx.resolution_502_ucs_manifest_stop_item to soro_anonymous;
    grant insert on table mtrx.resolution_502_ucs_manifest_stop_item to soro_anonymous;
  
  
  
    -------------- DISABLE ROW LEVEL SECURITY ----------------------
  
    alter table mtrx.resolution_502_ucs_manifest_stop_item disable row level security;
  
  
  --===================== END: mtrx.resolution_502_ucs_manifest_stop_item ===================
  
  --=================== BEGIN: mtrx.wa_502 ===================

  --------------------------------------------------------------------------------------------------------------------------------------------------
  -----------------------------------------------------  POLICY NAME:  New Table Policy  -------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------------

  -------------------------------------------------------- REMOVE EXISTING TABLE GRANTS ----------------------
  
    revoke all privileges on table mtrx.wa_502 from public;
    revoke all privileges on table mtrx.wa_502 from soro_super_admin;
    revoke all privileges on table mtrx.wa_502 from soro_admin;
    revoke all privileges on table mtrx.wa_502 from soro_user;
    revoke all privileges on table mtrx.wa_502 from soro_anonymous;
    revoke all privileges on table mtrx.wa_502 from soro_sync;
  
  -------------------------------------------------------- CREATE NEW TABLE GRANTS ----------------------

  -------------------------------------------------------- soro_anonymous
    grant select on table mtrx.wa_502 to soro_anonymous;
    grant insert on table mtrx.wa_502 to soro_anonymous;
  
  
  
    -------------- DISABLE ROW LEVEL SECURITY ----------------------
  
    alter table mtrx.wa_502 disable row level security;
  
  
  --===================== END: mtrx.wa_502 ===================
  