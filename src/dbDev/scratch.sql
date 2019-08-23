select * 
from information_schema.table_constraints
where table_name = 'organization'
;


select * 
from information_schema.key_column_usage
where table_name = 'organization'
;

-- drop index evt.idx_evt_tx_id_1;

-- drop index uq_evt_type_subscriber;
-- CREATE INDEX idx_evt_tx_id_1 ON evt.evt ( external_tx_id );
-- CREATE INDEX idx_evt_tx_id_2 ON evt.evt ( external_tx_id );



SELECT
  *
FROM
    pg_indexes
WHERE
    schemaname = 'evt'
ORDER BY
    tablename,
    indexname;
