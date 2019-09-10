drop schema if exists pgdbi_dev cascade;
create schema pgdbi_dev;

create type pgdbi_dev.enum_type AS ENUM (
  'Value_One',
  'Value_Two'
);

create sequence pgdbi_dev.global_id_sequence;
grant usage on sequence pgdbi_dev.global_id_sequence to app_user;

create OR REPLACE FUNCTION pgdbi_dev.id_generator(OUT result bigint) AS $$
declare
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

  create table pgdbi_dev.kitchen (
    id bigint unique not null DEFAULT pgdbi_dev.id_generator(),
    name text not null CHECK (name <> ''),
    identifier_one text not null CHECK (identifier_one <> ''),
    identifier_two text not null CHECK (identifier_two <> ''),
    identifier_three text not null CHECK (identifier_three <> ''),
    constraint uq_kitchen_name_identifier_one unique (name, identifier_one),
    constraint uq_kitchen_name_identifier_two unique (identifier_two, name),
    constraint uq_kitchen_name_identifier_three unique (name, identifier_three),
    constraint pk_kitchen primary key (id)
  );

  create table pgdbi_dev.sink (
    id bigint unique not null DEFAULT pgdbi_dev.id_generator(),
    fk_single_column_kitchen_id_with_index bigint not null,
    fk_single_column_kitchen_id_no_index bigint not null,
    fk_single_column_kitchen_id_multiple_index bigint not null,

    fk_multi_column_with_index_kitchen_name text not null,
    fk_multi_column_with_index_kitchen_identifier_one text not null,

    fk_multi_column_no_index_kitchen_name text not null,
    fk_multi_column_no_index_kitchen_identifier_two text not null,

    fk_multi_column_multiple_index_kitchen_name text not null,
    fk_multi_column_multiple_index_kitchen_identifier_three text not null,

    uq_single_column text not null unique,
    uq_single_column_multiple_index text not null unique,
    uq_multi_column_one text not null,
    uq_multi_column_two text not null,
    uq_multi_column_multiple_index_one text not null,
    uq_multi_column_multiple_index_two text not null,
    constraint pk_sink primary key (id)
  );
  alter table pgdbi_dev.sink add constraint fk_single_column_with_index foreign key ( fk_single_column_kitchen_id_with_index ) references pgdbi_dev.kitchen( id );
  create index idx_single_column_fk_with_index on pgdbi_dev.sink( fk_single_column_kitchen_id_with_index );

  alter table pgdbi_dev.sink add constraint fk_single_column_no_index foreign key ( fk_single_column_kitchen_id_no_index ) references pgdbi_dev.kitchen( id );

  alter table pgdbi_dev.sink add constraint fk_single_column_multiple_index foreign key ( fk_single_column_kitchen_id_multiple_index ) references pgdbi_dev.kitchen( id );
  create index idx_single_column_fk_with_multiple_index_one on pgdbi_dev.sink( fk_single_column_kitchen_id_multiple_index );
  create index idx_single_column_fk_with_multiple_index_two on pgdbi_dev.sink( fk_single_column_kitchen_id_multiple_index );

  alter table pgdbi_dev.sink add constraint fk_multi_column_with_index foreign key ( fk_multi_column_with_index_kitchen_name, fk_multi_column_with_index_kitchen_identifier_one ) references pgdbi_dev.kitchen( name, identifier_one );
  create index idx_fk_multi_column_with_index on pgdbi_dev.sink( fk_multi_column_with_index_kitchen_name, fk_multi_column_with_index_kitchen_identifier_one );

  alter table pgdbi_dev.sink add constraint fk_multi_column_no_index foreign key ( fk_multi_column_no_index_kitchen_name, fk_multi_column_no_index_kitchen_identifier_two ) references pgdbi_dev.kitchen( name, identifier_two );

  alter table pgdbi_dev.sink add constraint fk_multi_column_multiple_index foreign key ( fk_multi_column_multiple_index_kitchen_name, fk_multi_column_multiple_index_kitchen_identifier_three ) references pgdbi_dev.kitchen( name, identifier_one );
  create index idx_fk_multi_column_with_multiple_index_one on pgdbi_dev.sink( fk_multi_column_multiple_index_kitchen_name, fk_multi_column_multiple_index_kitchen_identifier_three );
  create index idx_fk_multi_column_with_multiple_index_two on pgdbi_dev.sink( fk_multi_column_multiple_index_kitchen_name, fk_multi_column_multiple_index_kitchen_identifier_three );

  create index idx_single_column_uq_with_multiple_index_two on pgdbi_dev.sink(uq_single_column_multiple_index);

  alter table pgdbi_dev.sink add constraint uq_multi_column unique (uq_multi_column_one, uq_multi_column_two);

  alter table pgdbi_dev.sink add constraint uq_multi_column_multiple_index unique (uq_multi_column_multiple_index_one, uq_multi_column_multiple_index_two);
  create index idx_multi_column_uq_with_multiple_index_two on pgdbi_dev.sink(uq_multi_column_multiple_index_one, uq_multi_column_multiple_index_two);


  -- before insert trigger  
  -- the trigger function
  create or replace function pgdbi_dev.fn_sink_before_insert() returns trigger AS $$
  begin
    -- before insert
    return NEW;
  end; $$ language plpgsql;

  -- the trigger
  create trigger tg_sink_before_insert
    before insert on pgdbi_dev.sink
    for each row
    execute procedure pgdbi_dev.fn_sink_before_insert();
  -- end before insert trigger

  -- after insert trigger  
  -- the trigger function
  create or replace function pgdbi_dev.fn_sink_after_insert() returns trigger AS $$
  begin
    -- after insert
    return NEW;
  end; $$ language plpgsql;

  -- the trigger
  create trigger tg_sink_after_insert
    after insert on pgdbi_dev.sink
    for each row
    execute procedure pgdbi_dev.fn_sink_after_insert();
  -- end after insert trigger

  -- before update trigger  
  -- the trigger function
  create or replace function pgdbi_dev.fn_sink_before_update() returns trigger AS $$
  begin
    -- before update
    return NEW;
  end; $$ language plpgsql;

  -- the trigger
  create trigger tg_sink_before_update
    before update on pgdbi_dev.sink
    for each row
    execute procedure pgdbi_dev.fn_sink_before_update();
  -- end before update trigger

  -- after update trigger  
  -- the trigger function
  create or replace function pgdbi_dev.fn_sink_after_update() returns trigger AS $$
  begin
    -- after update
    return NEW;
  end; $$ language plpgsql;

  -- the trigger
  create trigger tg_sink_after_update
    after update on pgdbi_dev.sink
    for each row
    execute procedure pgdbi_dev.fn_sink_after_update();
  -- end after update trigger

  -- before delete trigger  
  -- the trigger function
  create or replace function pgdbi_dev.fn_sink_before_delete() returns trigger AS $$
  begin
    -- before delete
    return NEW;
  end; $$ language plpgsql;

  -- the trigger
  create trigger tg_sink_before_delete
    before delete on pgdbi_dev.sink
    for each row
    execute procedure pgdbi_dev.fn_sink_before_delete();
  -- end before delete trigger

  -- after delete trigger  
  -- the trigger function
  create or replace function pgdbi_dev.fn_sink_after_delete() returns trigger AS $$
  begin
    -- after delete
    return NEW;
  end; $$ language plpgsql;

  -- the trigger
  create trigger tg_sink_after_delete
    after delete on pgdbi_dev.sink
    for each row
    execute procedure pgdbi_dev.fn_sink_after_delete();
  -- end after delete trigger


  create type pgdbi_dev.fn_options AS (option_1 int, option_2 text);

  CREATE OR REPLACE FUNCTION pgdbi_dev.fn_sample_function_with_options(
    param_1 text,
    param_2 jsonb,
    param_3 pgdbi_dev.fn_options
  )
  RETURNS text
  LANGUAGE plpgsql
  AS $function$
    begin
      -- before delete
      return param_1 || ' - ' || param_2::text || ' - ' || param_3::text;
    end; $function$

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
