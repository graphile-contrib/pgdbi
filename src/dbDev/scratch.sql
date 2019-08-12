select
  conname
  ,connamespace
  ,conrelid
  ,conindid
  ,conkey
  ,contype
from pg_constraint
where conname like '%facility%'
and contype = 'f'
-- limit 1
;