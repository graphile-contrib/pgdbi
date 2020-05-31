
----------
----------  BEGIN SCHEMA USAGE SQL
----------

REVOKE USAGE ON SCHEMA public FROM PUBLIC;

GRANT USAGE ON SCHEMA public TO app_authenticator;

------- app
  REVOKE USAGE ON SCHEMA app FROM PUBLIC;
  REVOKE USAGE ON SCHEMA app FROM app_authenticator
  REVOKE USAGE ON SCHEMA app FROM app_anonymous
  REVOKE USAGE ON SCHEMA app FROM app_visitor

  GRANT USAGE ON SCHEMA app TO app_visitor, app_anonymous;
------- auth
  REVOKE USAGE ON SCHEMA auth FROM PUBLIC;
  REVOKE USAGE ON SCHEMA auth FROM app_authenticator
  REVOKE USAGE ON SCHEMA auth FROM app_anonymous
  REVOKE USAGE ON SCHEMA auth FROM app_visitor

  GRANT USAGE ON SCHEMA auth TO app_visitor;
------- auth_fn
  REVOKE USAGE ON SCHEMA auth_fn FROM PUBLIC;
  REVOKE USAGE ON SCHEMA auth_fn FROM app_authenticator
  REVOKE USAGE ON SCHEMA auth_fn FROM app_anonymous
  REVOKE USAGE ON SCHEMA auth_fn FROM app_visitor

  GRANT USAGE ON SCHEMA auth_fn TO app_visitor;
------- lcb
  REVOKE USAGE ON SCHEMA lcb FROM PUBLIC;
  REVOKE USAGE ON SCHEMA lcb FROM app_authenticator
  REVOKE USAGE ON SCHEMA lcb FROM app_anonymous
  REVOKE USAGE ON SCHEMA lcb FROM app_visitor

  GRANT USAGE ON SCHEMA lcb TO app_visitor;
------- lcb_fn
  REVOKE USAGE ON SCHEMA lcb_fn FROM PUBLIC;
  REVOKE USAGE ON SCHEMA lcb_fn FROM app_authenticator
  REVOKE USAGE ON SCHEMA lcb_fn FROM app_anonymous
  REVOKE USAGE ON SCHEMA lcb_fn FROM app_visitor

  GRANT USAGE ON SCHEMA lcb_fn TO app_visitor;
------- lcb_hist
  REVOKE USAGE ON SCHEMA lcb_hist FROM PUBLIC;
  REVOKE USAGE ON SCHEMA lcb_hist FROM app_authenticator
  REVOKE USAGE ON SCHEMA lcb_hist FROM app_anonymous
  REVOKE USAGE ON SCHEMA lcb_hist FROM app_visitor

  GRANT USAGE ON SCHEMA lcb_hist TO app_visitor;
------- lcb_ref
  REVOKE USAGE ON SCHEMA lcb_ref FROM PUBLIC;
  REVOKE USAGE ON SCHEMA lcb_ref FROM app_authenticator
  REVOKE USAGE ON SCHEMA lcb_ref FROM app_anonymous
  REVOKE USAGE ON SCHEMA lcb_ref FROM app_visitor

  GRANT USAGE ON SCHEMA lcb_ref TO app_visitor;
------- org
  REVOKE USAGE ON SCHEMA org FROM PUBLIC;
  REVOKE USAGE ON SCHEMA org FROM app_authenticator
  REVOKE USAGE ON SCHEMA org FROM app_anonymous
  REVOKE USAGE ON SCHEMA org FROM app_visitor

  GRANT USAGE ON SCHEMA org TO app_visitor;
------- org_fn
  REVOKE USAGE ON SCHEMA org_fn FROM PUBLIC;
  REVOKE USAGE ON SCHEMA org_fn FROM app_authenticator
  REVOKE USAGE ON SCHEMA org_fn FROM app_anonymous
  REVOKE USAGE ON SCHEMA org_fn FROM app_visitor

  GRANT USAGE ON SCHEMA org_fn TO app_visitor;
----------
----------  END SCHEMA USAGE SQL
----------
--==
