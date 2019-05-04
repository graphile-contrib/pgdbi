// User Model
import { Model } from '@vuex-orm/core'
import Schema from './schema'

export default class SchemaTable extends Model {
  // This is the name used as module name of the Vuex Store.
  static entity = 'schemaTables'

  // List of all fields (schema) of the post model. `this.attr` is used
  // for the generic field type. The argument is the default value.
  static fields () {
    return {
      id: this.attr(null),
      name: this.attr(''),
      schemaId: this.attr(''),
      schema: this.belongsTo(Schema, 'schemaId', 'id')
    }
  }
}
