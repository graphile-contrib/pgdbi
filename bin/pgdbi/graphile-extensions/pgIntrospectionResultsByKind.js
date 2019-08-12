module.exports = callback => builder => builder.hook('build', (build) =>{callback(build.pgIntrospectionResultsByKind); return build})
