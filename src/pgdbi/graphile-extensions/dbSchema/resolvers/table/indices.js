module.exports = (build => {
  return async (
    _table,
    args,
    context,
    resolveInfo
  ) => {
    const { pgClient } = context;
    try {
    const tableSchema = _table.tableSchema
    const tableName = _table.tableName
  
    const sql = `
      select 
        ns.nspname || '.' || t.relname id
        ,t.relname "tableName"
        ,ns.nspname "tableSchema"
        ,a.attname "columnName"
        ,i.relname "indexName"
      from 
        pg_index ix
        join pg_class t on t.oid = ix.indrelid
        join pg_class i on i.oid = ix.indexrelid
        join pg_namespace ns on t.relnamespace = ns.oid
        join pg_attribute a on a.attrelid = t.oid and a.attnum = ANY(ix.indkey)
      where
        ns.nspname = '${tableSchema}'
      and
        t.relname = '${tableName}'
      group by
        ns.nspname,
        t.relname,
        a.attname,
        i.relname
      order by
          ns.nspname,
          t.relname,
          a.attname,
          i.relname
      ;
    `;

    const result = await pgClient.query(sql, []);
    return result.rows;
  } catch (e) {
      throw e;
    }
  }
})


// select 
// jsonb_build_object(
//   'tableIndices', (
//   coalesce(
//     array_agg(
//       jsonb_build_object(
//         'id', 'index:' || ns.nspname || '.' || t.relname
//         ,'tableName', t.relname
//         ,'tableSchema', ns.nspname
//         ,'columnName', a.attname
//         ,'indexName', i.relname
//         )
//       )
//     , '{}')
// )
// )
