select * 
from information_schema.table_constraints
where table_name = 'organization'
;


select * 
from information_schema.key_column_usage
where table_name = 'organization'
;