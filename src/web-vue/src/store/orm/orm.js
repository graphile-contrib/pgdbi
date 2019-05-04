import VuexORM from '@vuex-orm/core'
// import VuexORMGraphQL from '@vuex-orm/plugin-graphql';
import VuexORMSoftDeletePlugin from 'vuexorm-softdelete-plugin';
VuexORM.use(VuexORMSoftDeletePlugin);

import Schema  from './models/schema'
import SchemaTable  from './models/schemaTable'

// Create a new database instance.
const database = new VuexORM.Database()

// Register Models to the database.
database.register(Schema)
database.register(SchemaTable)

const orm = VuexORM.install(database)

export default orm