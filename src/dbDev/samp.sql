
----------
----------  BEGIN TABLE POLICY: org.company_web_link
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.company_web_link 
  from public;

  revoke all privileges 
  on table org.company_web_link 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'company_web_link'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.company_web_link enable row level security;

  create policy rls_soro_user_default_org_company_web_link 
    on org.company_web_link
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( id, company_id, web_link_id ), 
        -- no excluded columns
    update ( id, company_id, web_link_id ), 
        -- no excluded columns
    delete  
  on table org.company_web_link 
  to soro_user;



----------  END TABLE POLICY: org.company_web_link
--==
----------
----------  BEGIN TABLE POLICY: org.web_link
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.web_link 
  from public;

  revoke all privileges 
  on table org.web_link 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'web_link'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.web_link enable row level security;

  create policy rls_soro_user_default_org_web_link 
    on org.web_link
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( id, external_id, created_at, description, updated_at, url ), 
        -- no excluded columns
    update ( id, external_id, created_at, description, updated_at, url ), 
        -- no excluded columns
    delete  
  on table org.web_link 
  to soro_user;



----------  END TABLE POLICY: org.web_link
--==
----------
----------  BEGIN TABLE POLICY: org.contact_app_role
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.contact_app_role 
  from public;

  revoke all privileges 
  on table org.contact_app_role 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'contact_app_role'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.contact_app_role enable row level security;

  create policy rls_soro_user_default_org_contact_app_role 
    on org.contact_app_role
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( id, contact_id, role_id, seller_id ), 
        -- no excluded columns
    update ( id, contact_id, role_id, seller_id ), 
        -- no excluded columns
    delete  
  on table org.contact_app_role 
  to soro_user;



----------  END TABLE POLICY: org.contact_app_role
--==
----------
----------  BEGIN TABLE POLICY: org.customer_note
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.customer_note 
  from public;

  revoke all privileges 
  on table org.customer_note 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'customer_note'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.customer_note enable row level security;

  create policy rls_soro_user_default_org_customer_note 
    on org.customer_note
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( id, created_at, updated_at, customer_id, created_by_contact_id, content, note_date, seller_id ), 
        -- no excluded columns
    update ( id, created_at, updated_at, customer_id, created_by_contact_id, content, note_date, seller_id ), 
        -- no excluded columns
    delete  
  on table org.customer_note 
  to soro_user;



----------  END TABLE POLICY: org.customer_note
--==
----------
----------  BEGIN TABLE POLICY: org.vehicle
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.vehicle 
  from public;

  revoke all privileges 
  on table org.vehicle 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'vehicle'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.vehicle enable row level security;

  create policy rls_soro_user_default_org_vehicle 
    on org.vehicle
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( model, plate, make, year, vin, color, nickname, deleted, created_at, updated_at, seller_id, id ), 
        -- no excluded columns
    update ( model, plate, make, year, vin, color, nickname, deleted, created_at, updated_at, seller_id, id ), 
        -- no excluded columns
    delete  
  on table org.vehicle 
  to soro_user;



----------  END TABLE POLICY: org.vehicle
--==
----------
----------  BEGIN TABLE POLICY: org.registration
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.registration 
  from public;

  revoke all privileges 
  on table org.registration 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'registration'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.registration enable row level security;

  create policy rls_soro_user_default_org_registration 
    on org.registration
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( id, created_at, updated_at, location_id, first_name, last_name, email, phone, contacted_date, activated, comment ), 
        -- no excluded columns
    update ( id, created_at, updated_at, location_id, first_name, last_name, email, phone, contacted_date, activated, comment ), 
        -- no excluded columns
    delete  
  on table org.registration 
  to soro_user;



----------  END TABLE POLICY: org.registration
--==
----------
----------  BEGIN TABLE POLICY: org.contact_web_link
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.contact_web_link 
  from public;

  revoke all privileges 
  on table org.contact_web_link 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'contact_web_link'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.contact_web_link enable row level security;

  create policy rls_soro_user_default_org_contact_web_link 
    on org.contact_web_link
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( id, contact_id, web_link_id ), 
        -- no excluded columns
    update ( id, contact_id, web_link_id ), 
        -- no excluded columns
    delete  
  on table org.contact_web_link 
  to soro_user;



----------  END TABLE POLICY: org.contact_web_link
--==
----------
----------  BEGIN TABLE POLICY: org.customer_communication
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.customer_communication 
  from public;

  revoke all privileges 
  on table org.customer_communication 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'customer_communication'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.customer_communication enable row level security;

  create policy rls_soro_user_default_org_customer_communication 
    on org.customer_communication
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( id, created_at, updated_at, communication_timestamp, seller_id, customer_id, communication_type, message, goal, created_by_contact_id, target_contact_id, source_id, deleted ), 
        -- no excluded columns
    update ( id, created_at, updated_at, communication_timestamp, seller_id, customer_id, communication_type, message, goal, created_by_contact_id, target_contact_id, source_id, deleted ), 
        -- no excluded columns
    delete  
  on table org.customer_communication 
  to soro_user;



----------  END TABLE POLICY: org.customer_communication
--==
----------
----------  BEGIN TABLE POLICY: org.customer
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.customer 
  from public;

  revoke all privileges 
  on table org.customer 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'customer'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.customer enable row level security;

  create policy rls_soro_user_default_org_customer 
    on org.customer
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( id, external_id, created_at, default_discount_percent, updated_at, primary_buyer_contact_id, account_manager_contact_id, company_id, seller_id, order_frequency_days, total_sales, last_contact_date, next_contact_date, next_expected_order_date, first_order_date, last_order_date, display_alias, general_phone, website_url, priority, avg_order_amount, avg_line_items_per_order, last_fulfillment_date, secondary_buyer_contact_id, first_fulfillment_date, status ), 
        -- no excluded columns
    update ( id, external_id, created_at, default_discount_percent, updated_at, primary_buyer_contact_id, account_manager_contact_id, company_id, seller_id, order_frequency_days, total_sales, last_contact_date, next_contact_date, next_expected_order_date, first_order_date, last_order_date, display_alias, general_phone, website_url, priority, avg_order_amount, avg_line_items_per_order, last_fulfillment_date, secondary_buyer_contact_id, first_fulfillment_date, status ), 
        -- no excluded columns
    delete  
  on table org.customer 
  to soro_user;



----------  END TABLE POLICY: org.customer
--==
----------
----------  BEGIN TABLE POLICY: org.location
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.location 
  from public;

  revoke all privileges 
  on table org.location 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'location'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.location enable row level security;

  create policy rls_soro_user_default_org_location 
    on org.location
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( id, external_id, created_at, updated_at, name, address1, address2, city, state, zip, lat, lon, biotrack_id, global_identifier ), 
        -- no excluded columns
    update ( id, external_id, created_at, updated_at, name, address1, address2, city, state, zip, lat, lon, biotrack_id, global_identifier ), 
        -- no excluded columns
    delete  
  on table org.location 
  to soro_user;



----------  END TABLE POLICY: org.location
--==
----------
----------  BEGIN TABLE POLICY: org.seller
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.seller 
  from public;

  revoke all privileges 
  on table org.seller 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'seller'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.seller enable row level security;

  create policy rls_soro_user_default_org_seller 
    on org.seller
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( id, external_id, created_at, next_quote_number, next_order_number, default_account_manager_contact_id, updated_at, company_id, display_alias ), 
        -- no excluded columns
    update ( id, external_id, created_at, next_quote_number, next_order_number, default_account_manager_contact_id, updated_at, company_id, display_alias ), 
        -- no excluded columns
    delete  
  on table org.seller 
  to soro_user;



----------  END TABLE POLICY: org.seller
--==
----------
----------  BEGIN TABLE POLICY: org.contact
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.contact 
  from public;

  revoke all privileges 
  on table org.contact 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'contact'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.contact enable row level security;

  create policy rls_soro_user_default_org_contact 
    on org.contact
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( id, external_id, created_at, updated_at, email, first_name, last_name, cell_phone, office_phone, role, location_id, company_id, customer_id, preferred_contact_method, birth_date, hire_date, note, retired ), 
        -- no excluded columns
    update ( id, external_id, created_at, updated_at, email, first_name, last_name, cell_phone, office_phone, role, location_id, company_id, customer_id, preferred_contact_method, birth_date, hire_date, note, retired ), 
        -- no excluded columns
    delete  
  on table org.contact 
  to soro_user;



----------  END TABLE POLICY: org.contact
--==
----------
----------  BEGIN TABLE POLICY: org.company
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.company 
  from public;

  revoke all privileges 
  on table org.company 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'company'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.company enable row level security;

  create policy rls_soro_user_default_org_company 
    on org.company
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( id, external_id, licenses, company_type, created_at, name, updated_at, location_id ), 
        -- no excluded columns
    update ( id, external_id, licenses, company_type, created_at, name, updated_at, location_id ), 
        -- no excluded columns
    delete  
  on table org.company 
  to soro_user;



----------  END TABLE POLICY: org.company
--==
----------
----------  BEGIN TABLE POLICY: org.account_note
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.account_note 
  from public;

  revoke all privileges 
  on table org.account_note 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'account_note'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.account_note enable row level security;

  create policy rls_soro_user_default_org_account_note 
    on org.account_note
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( id, created_at, updated_at, seller_id, customer_id, content, created_by_contact_id ), 
        -- no excluded columns
    update ( id, created_at, updated_at, seller_id, customer_id, content, created_by_contact_id ), 
        -- no excluded columns
    delete  
  on table org.account_note 
  to soro_user;



----------  END TABLE POLICY: org.account_note
--==
----------
----------  BEGIN TABLE POLICY: org.customer_contact_app_role
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.customer_contact_app_role 
  from public;

  revoke all privileges 
  on table org.customer_contact_app_role 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'customer_contact_app_role'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.customer_contact_app_role enable row level security;

  create policy rls_soro_user_default_org_customer_contact_app_role 
    on org.customer_contact_app_role
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( id, customer_id, contact_id, role_id, seller_id ), 
        -- no excluded columns
    update ( id, customer_id, contact_id, role_id, seller_id ), 
        -- no excluded columns
    delete  
  on table org.customer_contact_app_role 
  to soro_user;



----------  END TABLE POLICY: org.customer_contact_app_role
--==
----------
----------  BEGIN TABLE POLICY: org.attachment
----------  POLICY NAME:  soro_user:  with default rls
----------

----------  REMOVE EXISTING TABLE GRANTS

  revoke all privileges 
  on table org.attachment 
  from public;

  revoke all privileges 
  on table org.attachment 
  from soro_super_admin, soro_admin, soro_user, soro_demon, soro_anonymous, soro_sync;

----------  ENABLE ROW LEVEL SECURITY

  ----------
  ----------  remove all rls policies for table
  ----------
  DO
  $body$
    DECLARE 
      _pol pg_policies;
      _drop_sql text;
    BEGIN

      for _pol in
        select 
          *
        from pg_policies
        where schemaname = 'org'
        and tablename = 'attachment'
      loop
        _drop_sql := 'drop policy if exists ' || _pol.policyname || ' on ' || _pol.schemaname || '.' || _pol.tablename || ';';
        execute _drop_sql;
      end loop
      ;
    END
  $body$;

  alter table org.attachment enable row level security;

  create policy rls_soro_user_default_org_attachment 
    on org.attachment
    as permissive
    for all
    to soro_user
    using ( seller_id = soro_app_fn.viewer_company_id() )
    ;


----------  CREATE NEW TABLE GRANTS

----------  soro_user
  grant 
    select , 
    insert ( id, seller_id, name, url, attachment_type ), 
        -- no excluded columns
    update ( id, seller_id, name, url, attachment_type ), 
        -- no excluded columns
    delete  
  on table org.attachment 
  to soro_user;



----------  END TABLE POLICY: org.attachment
--==