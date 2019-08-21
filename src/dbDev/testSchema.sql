  CREATE TRIGGER tg_timestamp_update_evt_before
    BEFORE INSERT OR UPDATE OR DELETE ON evt.evt
    FOR EACH ROW
    EXECUTE PROCEDURE evt.fn_timestamp_update_evt();

  CREATE TRIGGER _tg_timestamp_update_evt_before
    BEFORE INSERT OR UPDATE OR DELETE ON evt.evt
    FOR EACH ROW
    EXECUTE PROCEDURE evt.fn_timestamp_update_evt();

  CREATE TRIGGER _100_tg_timestamp_update_evt_before
    BEFORE INSERT OR UPDATE OR DELETE ON evt.evt
    FOR EACH ROW
    EXECUTE PROCEDURE evt.fn_timestamp_update_evt();

  CREATE TRIGGER _200_tg_timestamp_update_evt_before
    BEFORE INSERT OR UPDATE OR DELETE ON evt.evt
    FOR EACH ROW
    EXECUTE PROCEDURE evt.fn_timestamp_update_evt();

  CREATE TRIGGER tg_timestamp_update_evt_after
    AFTER INSERT OR UPDATE OR DELETE ON evt.evt
    FOR EACH ROW
    EXECUTE PROCEDURE evt.fn_timestamp_update_evt();

  CREATE TRIGGER _tg_timestamp_update_evt_after
    AFTER INSERT OR UPDATE OR DELETE ON evt.evt
    FOR EACH ROW
    EXECUTE PROCEDURE evt.fn_timestamp_update_evt();

  CREATE TRIGGER _100_tg_timestamp_update_evt_after
    AFTER INSERT OR UPDATE OR DELETE ON evt.evt
    FOR EACH ROW
    EXECUTE PROCEDURE evt.fn_timestamp_update_evt();

  CREATE TRIGGER _200_tg_timestamp_update_evt_after
    AFTER INSERT OR UPDATE OR DELETE ON evt.evt
    FOR EACH ROW
    EXECUTE PROCEDURE evt.fn_timestamp_update_evt();

select
  trigger_schema
  ,trigger_name
  ,action_statement
  ,action_timing
  ,event_manipulation
  -- 'drop trigger if exists ' || trigger_name || ' on evt.evt;'
from information_schema.triggers where event_object_table = 'evt'
order by
  event_manipulation
  ,action_timing
;


 
--  drop trigger if exists tg_timestamp_update_evt_after on evt.evt;
--  drop trigger if exists _tg_timestamp_update_evt_after on evt.evt;
--  drop trigger if exists _200_tg_timestamp_update_evt_after on evt.evt;
--  drop trigger if exists _100_tg_timestamp_update_evt_after on evt.evt;
--  drop trigger if exists _100_tg_timestamp_update_evt_before on evt.evt;
--  drop trigger if exists tg_timestamp_update_evt_before on evt.evt;
--  drop trigger if exists _200_tg_timestamp_update_evt_before on evt.evt;
--  drop trigger if exists _tg_timestamp_update_evt_before on evt.evt;
--  drop trigger if exists _100_tg_timestamp_update_evt_after on evt.evt;
--  drop trigger if exists _tg_timestamp_update_evt_after on evt.evt;
--  drop trigger if exists _200_tg_timestamp_update_evt_after on evt.evt;
--  drop trigger if exists tg_timestamp_update_evt_after on evt.evt;
--  drop trigger if exists tg_timestamp_update_evt_before on evt.evt;
--  drop trigger if exists _tg_timestamp_update_evt_before on evt.evt;
--  drop trigger if exists _100_tg_timestamp_update_evt_before on evt.evt;
--  drop trigger if exists _200_tg_timestamp_update_evt_before on evt.evt;
--  drop trigger if exists _200_tg_timestamp_update_evt_after on evt.evt;
--  drop trigger if exists _tg_timestamp_update_evt_after on evt.evt;
--  drop trigger if exists _100_tg_timestamp_update_evt_after on evt.evt;
--  drop trigger if exists tg_timestamp_update_evt_after on evt.evt;
--  drop trigger if exists tg_timestamp_update_evt_before on evt.evt;
--  drop trigger if exists _tg_timestamp_update_evt_before on evt.evt;
--  drop trigger if exists _200_tg_timestamp_update_evt_before on evt.evt;
--  drop trigger if exists _100_tg_timestamp_update_evt_before on evt.evt;