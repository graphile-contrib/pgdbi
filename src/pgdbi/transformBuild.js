const camelCaseKeys = require('camelcase-keys')
const pg10IntrospectionQuery = require('./pg10IntrospectionQuery')

const queryBuilderMap = {
  "10": require('./pg10IntrospectionQuery'),
  "11": require('./pg11IntrospectionQuery')
}

async function transformBuild(build, pgPool) {
  try {
    const version = (await pgPool.query('SHOW server_version;')).rows[0].server_version.split('.')[0];
    console.log('version', version)
    const schemas = build.options.pgSchemas.join("','");
    const querySql = await queryBuilderMap[version](schemas)
    const schemaTree = camelCaseKeys((await pgPool.query(querySql)).rows[0], {deep:true})
    return schemaTree

  } catch (e) {
    console.log('CAUGHT ERROR', e.toString())
    throw e;
  }
}

module.exports = transformBuild