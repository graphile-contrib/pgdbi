drop schema if exists pgdbi_dev cascade;
create schema pgdbi_dev;

create sequence pgdbi_dev.global_id_sequence;
grant usage on sequence pgdbi_dev.global_id_sequence to app_user;

CREATE OR REPLACE FUNCTION pgdbi_dev.id_generator(OUT result bigint) AS $$
DECLARE
    our_epoch bigint := 1314220021721;
    seq_id bigint;
    now_millis bigint;
    -- the id of this DB shard, must be set for each
    -- schema shard you have - you could pass this as a parameter too
    shard_id int := 1;
BEGIN
    SELECT nextval('pgdbi_dev.global_id_sequence') % 1024 INTO seq_id;

    SELECT FLOOR(EXTRACT(EPOCH FROM clock_timestamp()) * 1000) INTO now_millis;
    result := (now_millis - our_epoch) << 23;
    result := result | (shard_id << 10);
    result := result | (seq_id);
END;
$$ LANGUAGE PLPGSQL;

  GRANT execute ON FUNCTION pgdbi_dev.id_generator(
  ) TO app_user;

  create table pgdbi_dev.manufacturer (
    id bigint unique not null DEFAULT pgdbi_dev.id_generator(),
    name text not null CHECK (name <> ''),
    constraint pk_manufacturer primary key (id)
  );

  create table pgdbi_dev.brand (
    id bigint unique not null DEFAULT pgdbi_dev.id_generator(),
    manufacturer_id bigint not null,
    name text not null CHECK (name <> ''),
    constraint pk_brand primary key (id)
  );

  create table pgdbi_dev.kitchen (
    id bigint unique not null DEFAULT pgdbi_dev.id_generator(),
    name text not null CHECK (name <> ''),
    constraint pk_kitchen primary key (id)
  );

  create table pgdbi_dev.sink (
    id bigint unique not null DEFAULT pgdbi_dev.id_generator(),
    kitchen_id bigint not null,
    ordinal integer not null,
    constraint uq_kitchen_sink_ordinal unique (kitchen_id, ordinal),
    constraint pk_sink primary key (id)
  );
  alter table pgdbi_dev.sink add constraint fk_sink_kitchen foreign key ( kitchen_id ) references pgdbi_dev.kitchen( id );

  create table pgdbi_dev.faucet (
    id bigint unique not null DEFAULT pgdbi_dev.id_generator(),
    sink_id bigint not null unique,
    serial_number text unique not null check(serial_number != ''),
    manufacturer_id bigint not null,
    brand_id bigint not null,
    constraint uq_good_unique_constraint unique (manufacturer_id, serial_number), -- uq_good_unique_constraint
    constraint pk_faucet primary key (id)
  );
  alter table pgdbi_dev.faucet add constraint fk_faucet_sink foreign key ( sink_id ) references pgdbi_dev.sink( id );
  alter table pgdbi_dev.faucet add constraint fk_faucet_manufacturer foreign key ( manufacturer_id ) references pgdbi_dev.manufacturer( id );
  alter table pgdbi_dev.faucet add constraint fk_faucet_brand_no_index foreign key ( brand_id ) references pgdbi_dev.brand( id );

  create table pgdbi_dev.basin (
    id bigint unique not null DEFAULT pgdbi_dev.id_generator(),
    sink_id bigint not null unique,
    serial_number text unique not null check(serial_number != ''),
    manufacturer_id bigint not null,
    brand_id bigint not null,
    constraint uq_basin_manufacturer_serial_number unique (manufacturer_id, serial_number),
    constraint uq_duplicate_unique_constraint unique (manufacturer_id, serial_number),
    constraint pk_basin primary key (id)
  );
  alter table pgdbi_dev.basin add constraint fk_basin_sink foreign key ( sink_id ) references pgdbi_dev.sink( id );
  alter table pgdbi_dev.basin add constraint fk_basin_manufacturer foreign key ( manufacturer_id ) references pgdbi_dev.manufacturer( id );
  alter table pgdbi_dev.basin add constraint fk_basin_brand foreign key ( brand_id ) references pgdbi_dev.brand( id );

  create table pgdbi_dev.contrived_sink_reference (
    id bigint unique not null DEFAULT pgdbi_dev.id_generator(),
    kitchen_id bigint not null,
    ordinal integer not null,
    singleton_value integer not null,
    constraint uq_contrived_sink_reference_single_column unique (singleton_value),
    constraint uq_contrived_sink_reference_multi_column unique (kitchen_id, ordinal),
    constraint pk_contrived_sink_reference primary key (id)
  );
  alter table pgdbi_dev.contrived_sink_reference add constraint fk_contrived_sink_reference_with_index foreign key ( kitchen_id, ordinal ) references pgdbi_dev.sink( kitchen_id, ordinal );
  create index idx_contrived_sink_reference_with_index on pgdbi_dev.contrived_sink_reference( kitchen_id, ordinal);


  -- before insert/update trigger
  
  -- the trigger function
  create or replace function pgdbi_dev.fn_timestamp_update_sink() returns trigger AS $$
  begin
    if NEW.app_tenant_id is null then 
      -- only users with 'SuperAdmin' permission_key will be able to arbitrarily set this value
      -- rls policy (below) will prevent users from specifying an alternate app_tenant_id
      NEW.app_tenant_id := auth_fn.current_app_tenant_id();
    end if;

    NEW.updated_at = current_timestamp;

    return NEW;
  end; $$ language plpgsql;


  -- the trigger
  create trigger tg_timestamp_update_sink
    before insert or update on pgdbi_dev.sink
    for each row
    execute procedure pgdbi_dev.fn_timestamp_update_sink();

  -- end before insert/update trigger



  -- security
  -- these settings will vary depending on your application, and should be actively managed
  -- for most entities, access to app_user role for all CRUD operations will be appropriate
  -- grant select ON table pgdbi_dev.sink TO app_user;
  -- grant insert ON table pgdbi_dev.sink TO app_user;
  -- grant update ON table pgdbi_dev.sink TO app_user;
  -- grant delete ON table pgdbi_dev.sink TO app_user;

  -- -- enable row-level security
  -- alter table pgdbi_dev.sink enable row level security;
  -- -- define a security policy.  your application may require more complexity.
  -- create policy all_sink on pgdbi_dev.sink for all to app_user  -- sql action could change according to your needs
  -- using (app_tenant_id = auth_fn.current_app_tenant_id());  -- this function could be replaced entirely or on individual policies as needed

  -- create policy super_aadmin_sink on pgdbi_dev.sink for all to app_super_admin
  -- using (1 = 1);


  -- -- postgraphile smart comments to configure the API:   https://www.graphile.org/postgraphile/smart-comments/
  -- comment on column pgdbi_dev.sink.app_tenant_id is
  -- E'@omit create'; -- id is always set by the db.  this might change in an event-sourcing scenario
  -- comment on column pgdbi_dev.sink.id is
  -- E'@omit create'; -- id is always set by the db.  this might change in an event-sourcing scenario
  -- comment on column pgdbi_dev.sink.created_at is
  -- E'@omit create,update'; -- created_at is always set by the db.  this might change in an event-sourcing scenario
  -- comment on column pgdbi_dev.sink.updated_at is
  -- E'@omit create,update'; -- updated_at is always set by the db.  this might change in an event-sourcing scenario
