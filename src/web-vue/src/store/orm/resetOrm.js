import Schema from './models/schema'
import SchemaTable from './models/schemaTable'

function resetOrm(){
  SchemaTable.deleteAll()
  Schema.deleteAll()
}

export default resetOrm