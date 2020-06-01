
----------
----------  BEGIN SCHEMA USAGE SQL
----------

REVOKE USAGE ON SCHEMA public FROM PUBLIC;

GRANT USAGE ON SCHEMA public TO app_authenticator;

------- app
  REVOKE USAGE ON SCHEMA app FROM PUBLIC;
  REVOKE USAGE ON SCHEMA app FROM app_authenticator;
  REVOKE USAGE ON SCHEMA app FROM app_anonymous;
  REVOKE USAGE ON SCHEMA app FROM app_user;
  REVOKE USAGE ON SCHEMA app FROM app_admin;
  REVOKE USAGE ON SCHEMA app FROM app_super_admin;

------- auth
  REVOKE USAGE ON SCHEMA auth FROM PUBLIC;
  REVOKE USAGE ON SCHEMA auth FROM app_authenticator;
  REVOKE USAGE ON SCHEMA auth FROM app_anonymous;
  REVOKE USAGE ON SCHEMA auth FROM app_user;
  REVOKE USAGE ON SCHEMA auth FROM app_admin;
  REVOKE USAGE ON SCHEMA auth FROM app_super_admin;

------- auth_fn
  REVOKE USAGE ON SCHEMA auth_fn FROM PUBLIC;
  REVOKE USAGE ON SCHEMA auth_fn FROM app_authenticator;
  REVOKE USAGE ON SCHEMA auth_fn FROM app_anonymous;
  REVOKE USAGE ON SCHEMA auth_fn FROM app_user;
  REVOKE USAGE ON SCHEMA auth_fn FROM app_admin;
  REVOKE USAGE ON SCHEMA auth_fn FROM app_super_admin;

------- lcb
  REVOKE USAGE ON SCHEMA lcb FROM PUBLIC;
  REVOKE USAGE ON SCHEMA lcb FROM app_authenticator;
  REVOKE USAGE ON SCHEMA lcb FROM app_anonymous;
  REVOKE USAGE ON SCHEMA lcb FROM app_user;
  REVOKE USAGE ON SCHEMA lcb FROM app_admin;
  REVOKE USAGE ON SCHEMA lcb FROM app_super_admin;

------- lcb_fn
  REVOKE USAGE ON SCHEMA lcb_fn FROM PUBLIC;
  REVOKE USAGE ON SCHEMA lcb_fn FROM app_authenticator;
  REVOKE USAGE ON SCHEMA lcb_fn FROM app_anonymous;
  REVOKE USAGE ON SCHEMA lcb_fn FROM app_user;
  REVOKE USAGE ON SCHEMA lcb_fn FROM app_admin;
  REVOKE USAGE ON SCHEMA lcb_fn FROM app_super_admin;

------- lcb_hist
  REVOKE USAGE ON SCHEMA lcb_hist FROM PUBLIC;
  REVOKE USAGE ON SCHEMA lcb_hist FROM app_authenticator;
  REVOKE USAGE ON SCHEMA lcb_hist FROM app_anonymous;
  REVOKE USAGE ON SCHEMA lcb_hist FROM app_user;
  REVOKE USAGE ON SCHEMA lcb_hist FROM app_admin;
  REVOKE USAGE ON SCHEMA lcb_hist FROM app_super_admin;

------- lcb_ref
  REVOKE USAGE ON SCHEMA lcb_ref FROM PUBLIC;
  REVOKE USAGE ON SCHEMA lcb_ref FROM app_authenticator;
  REVOKE USAGE ON SCHEMA lcb_ref FROM app_anonymous;
  REVOKE USAGE ON SCHEMA lcb_ref FROM app_user;
  REVOKE USAGE ON SCHEMA lcb_ref FROM app_admin;
  REVOKE USAGE ON SCHEMA lcb_ref FROM app_super_admin;

------- org
  REVOKE USAGE ON SCHEMA org FROM PUBLIC;
  REVOKE USAGE ON SCHEMA org FROM app_authenticator;
  REVOKE USAGE ON SCHEMA org FROM app_anonymous;
  REVOKE USAGE ON SCHEMA org FROM app_user;
  REVOKE USAGE ON SCHEMA org FROM app_admin;
  REVOKE USAGE ON SCHEMA org FROM app_super_admin;

------- org_fn
  REVOKE USAGE ON SCHEMA org_fn FROM PUBLIC;
  REVOKE USAGE ON SCHEMA org_fn FROM app_authenticator;
  REVOKE USAGE ON SCHEMA org_fn FROM app_anonymous;
  REVOKE USAGE ON SCHEMA org_fn FROM app_user;
  REVOKE USAGE ON SCHEMA org_fn FROM app_admin;
  REVOKE USAGE ON SCHEMA org_fn FROM app_super_admin;

----------
----------  END SCHEMA USAGE SQL
----------
--==
