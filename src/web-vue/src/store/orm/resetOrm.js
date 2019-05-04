import Schema from './models/schema'
import SchemaTable from './models/schemaTable'

function resetOrm(){
  console.log('wtf')
  // SchemaTable.softDelete(r => { return r !== null })
  // Schema.softDelete(r => { return r !== null })
  SchemaTable.deleteAll()
  Schema.deleteAll()
}

export default resetOrm