const clog = require('fbkt-clog')

module.exports = (build => {
  return async (
    _schema,
    args,
    context,
    resolveInfo
  ) => {
    const { pgClient } = context;
    try {
      const schemaName = _schema.schemaName
  
  const sql = `
  select jsonb_build_object(
    'id', 'enum:' || n.nspname || '.' || t.typname
    ,'enumName', t.typname
    ,'enumSchema', n.nspname
    ,'enumValues', (
      with vals as(
       select e.enumlabel
       from pg_enum e
       where e.enumtypid = t.oid
       order by e.enumlabel
      )
      select array_agg(enumlabel)
      from vals
    )
  )
  from pg_type t
      join pg_catalog.pg_namespace n ON n.oid = t.typnamespace
      where t.oid in (select enumtypid from pg_enum)
      and n.nspname = '${schemaName}'
      group by
      n.nspname
      ,t.typname
      ,t.oid
      order by 
        t.typname
      ;
`;

    const result = await pgClient.query(sql, []);

    return result.rows.map(
      r => {
        return r.jsonb_build_object
      }
    );
  } catch (e) {
      throw e;
    }
  }
})
