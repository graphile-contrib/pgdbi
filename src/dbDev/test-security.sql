
  --=================== BEGIN: mtrx.discrepancy_502 ===================

  --------------------------------------------------------------------------------------------------------------------------------------------------
  -----------------------------------------------------  POLICY NAME:  Custom Policy: mtrx.discrepancy_502  -------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------------

  -------------------------------------------------------- REMOVE EXISTING TABLE GRANTS ----------------------
  
    revoke all privileges on table mtrx.discrepancy_502 from public;
    revoke all privileges on table mtrx.discrepancy_502 from app_super_admin;
    revoke all privileges on table mtrx.discrepancy_502 from app_admin;
    revoke all privileges on table mtrx.discrepancy_502 from app_user;
    revoke all privileges on table mtrx.discrepancy_502 from app_anonymous;
    revoke all privileges on table mtrx.discrepancy_502 from app_demon;
  
  -------------------------------------------------------- CREATE NEW TABLE GRANTS ----------------------

  -------------------------------------------------------- app_user
    grant select on table mtrx.discrepancy_502 to app_user;
  
  
  
    -------------- DISABLE ROW LEVEL SECURITY ----------------------
  
    alter table mtrx.discrepancy_502 disable row level security;
  
  
  --===================== END: mtrx.discrepancy_502 ===================
  