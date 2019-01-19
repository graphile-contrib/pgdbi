
-- -- brand
-- REVOKE ALL PRIVILEGES ON soro.brand FROM PUBLIC;
-- ALTER TABLE soro.brand DISABLE ROW LEVEL SECURITY;
-- DROP POLICY IF EXISTS all_brand ON soro.brand;

-- GRANT select, update, delete ON TABLE soro.brand TO soro_user;
-- --||--
-- ALTER TABLE soro.brand ENABLE ROW LEVEL SECURITY;
-- CREATE POLICY all_brand ON soro.brand FOR SELECT
-- USING (seller_id = (SELECT company_id FROM soro.contact WHERE id = current_setting('jwt.claims.contact_id')::uuid));


  REVOKE ALL PRIVILEGES ON org.organization FROM app_user;
  ALTER TABLE org.organization DISABLE ROW LEVEL SECURITY;
  DROP POLICY IF EXISTS select_organization ON org.organization;

  --||--

  GRANT select ON TABLE org.organization TO app_user;
  GRANT insert ON TABLE org.organization TO app_user;
  GRANT update ON TABLE org.organization TO app_user;
  GRANT delete ON TABLE org.organization TO app_user;
  --||--
  alter table org.organization enable row level security;
  --||--
  create policy select_organization on org.organization for select
    using (auth_fn.app_user_has_access(app_tenant_id) = true);

  comment on table org.organization is E'@omit create,update,delete';
