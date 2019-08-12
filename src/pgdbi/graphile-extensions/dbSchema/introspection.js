const util = require('util')
const pgdbiApp = require('../../index')

function cleanObj(obj){
  return Object.keys(obj).filter(k => [
    'class'
    ,'type'
    ,'attributes'
    ,'constraints'
    ,'foreignKeyAttributes'
    ,'foreignConstraints'
    ,'primaryKeyConstraint'
    ,"foreignClass"
    ,"keyAttributes"
    ,"arrayType"
    ,"arrayItemType"
    ,"domainBaseType"
].indexOf(k) === -1
  )
    .reduce(
      (o, k) => {
        return {
          ...o
          ,[k]: obj[k]
        }
      }, {}
    )
}

module.exports = build => {
  return async (_schema, args, context, resolveInfo) => {
    try {
      const currentBuild = pgdbiApp.currentBuild()

      const schemaTree = currentBuild.options.pgSchemas.map(
        schemaName => {
          return {
            id: `schema:${schemaName}`
            ,name: schemaName
          }
        }
      )
      .map(
        s => {

          const tables = currentBuild.pgIntrospectionResultsByKind.class.filter(c => c.namespaceName === s.name)
            .filter(c => c.name === 'organization')
            .map(
              t => {
                const theTableById = currentBuild.pgIntrospectionResultsByKind.classById[t.id]

                const attributes = (theTableById.attributes || []).map(
                  a => {
                    console.log(util.inspect(a.type,null,6))
                    console.log(a.type)
                    return {
                      ...cleanObj(a)
                      ,id: `attribute:${s.name}:${t.name}:${a.name}`
                      ,type: cleanObj(a.type)
                    }
                  }
                )
                
                const foreignKeyAttributes = (theTableById.foreignKeyAttributes || []).map(
                  a => {
                    return {
                      ...cleanObj(a)
                      ,id: `foreignKeyAttribute:${s.name}:${t.name}:${a.name}`
                    }
                  }
                )
                
                const foreignConstraints = (theTableById.foreignConstraints || []).map(
                  a => {
                    return {
                      ...cleanObj(a)
                      ,id: `foreignConstraint:${s.name}:${t.name}:${a.name}`
                    }
                  }
                )

                const primaryKeyConstraint = {
                  ...cleanObj(theTableById.primaryKeyConstraint || {})
                  ,id: `primaryKeyConstraint:${s.name}:${t.name}:${t.primaryKeyConstraint.name}`
                }
                
                const constraints = (theTableById.constraints || []).map(
                  a => {
                    return {
                      id: `constraint:${s.name}:${t.name}:${a.name}`
                      ,...cleanObj(a)
                      // ,foreignClass: cleanObj(a.foreignClass || {})
                      ,keyAttributes: a.keyAttributes.map(
                        ka => {
                          return {
                            id: `keyAttribute:${s.name}:${t.name}:${a.name}:${ka.name}`
                            ,...cleanObj(ka)
                          }
                        }
                      )
                    }
                  }
                )
                
                return {
                  ...cleanObj(theTableById)
                  ,id: `table:${s.name}:${theTableById.name}`
                  ,schemaName: s.name
                  ,attributes: attributes
                  ,primaryKeyConstraint: primaryKeyConstraint
                  ,foreignKeyAttributes: foreignKeyAttributes
                  ,foreignConstraints: foreignConstraints
                  ,constraints: constraints
                }                           
            }
          )
  
          return {
            ...s
            ,tables: tables
          }
        }
      )
      .map(
        s => {
          const types = currentBuild.pgIntrospectionResultsByKind.type.filter(t => t.namespaceName === s.name)
            .map(
              t => {
                const theTypeById = currentBuild.pgIntrospectionResultsByKind.typeById[t.id]
                return {
                  ...cleanObj(theTypeById)
                  ,id: `type:${s.name}:${theTypeById.name}`
                }
              }
            )
          
          return {
            ...s
            ,types: types
          }
  
        }
      )

      return {
        schemaTree: schemaTree
      }
    } catch (e) {
      throw e;
    }
  };
};
