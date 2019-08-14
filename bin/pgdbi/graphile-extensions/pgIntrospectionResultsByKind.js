module.exports = callback => builder => builder.hook('build', (build) =>{console.log('heyo'); callback(build.pgIntrospectionResultsByKind); return build})
