drop schema information_schema_pg_calc cascade;

create schema information_schema_pg_calc;

------------------------------------------------
-- schema_tables
------------------------------------------------
create or replace function information_schema_pg_calc.schemata_tables(s information_schema.schemata)
returns setof information_schema.tables as $$
    select *
    from information_schema.tables t
    WHERE t.table_schema = s.schema_name
  ;
$$ language sql stable;



------------------------------------------------
-- schema_tables
------------------------------------------------
create or replace function information_schema_pg_calc.tables_columns(t information_schema.tables)
returns setof information_schema.columns as $$
    select *
    from information_schema.columns c
    WHERE t.table_schema = c.table_schema
    and t.table_name = c.column_name
  ;
$$ language sql stable;


-- DO $$
-- DECLARE _table information_schema.tables;
-- DECLARE _columns information_schema.columns[];
-- BEGIN
--     SELECt *
--     INTO _table
--     from information_schema.tables 
--     where table_schema = 'auth' 
--     and table_name = 'app_tenant'
--     ;
-- 
--     SELECT information_schema_pg_calc.tables_columns(_table) into _columns;
-- 
--   RAISE NOTICE 'table: %', _table;
--   RAISE NOTICE '_columns: %', _columns;
-- 
-- END 
-- $$;


-- 
-- DO $$
-- DECLARE v_List TEXT;
-- BEGIN
--   v_List := 'foobar' ;
--   RAISE NOTICE '%', v_list;
--   -- ...
-- END $$;

COMMENT ON VIEW "pg_catalog"."pg_indexes" IS E'@name pg_indexes_vw';
COMMENT ON VIEW "pg_catalog"."pg_policies" IS E'@name pg_policies_vw';
COMMENT ON VIEW "pg_catalog"."pg_seclabels" IS E'@name pg_seclabels_vw';
COMMENT ON VIEW "pg_catalog"."pg_user_mappings" IS E'@name pg_user_mappings_vw';
COMMENT ON VIEW "pg_catalog"."pg_available_extension_versions" IS E'@name pg_available_extension_versions_view';
COMMENT ON VIEW "pg_catalog"."pg_available_extensions" IS E'@name pg_available_extensions_vw';
COMMENT ON VIEW "pg_catalog"."pg_timezone_abbrevs" IS E'@name pg_timezone_abbrevs_vw';
COMMENT ON VIEW "pg_catalog"."pg_timezone_names" IS E'@name pg_timezone_names_vw';