import Mustache from "mustache"

const schemaUsageSqlTemplate = `
----------
----------  BEGIN SCHEMA USAGE SQL
----------

REVOKE USAGE ON SCHEMA public FROM PUBLIC;

GRANT USAGE ON SCHEMA public TO {{appAuthenticator}};

{{#schemata}}
------- {{schemaName}}
  REVOKE USAGE ON SCHEMA {{schemaName}} FROM PUBLIC;
  {{#rolesToRevoke}}
  REVOKE USAGE ON SCHEMA {{schemaName}} FROM {{roleName}};
  {{/rolesToRevoke}}

  {{#rolesToGrant}}
  GRANT USAGE ON SCHEMA {{schemaName}} TO {{.}};
  {{/rolesToGrant}}
{{/schemata}}
----------
----------  END SCHEMA USAGE SQL
----------
--==
`

function mergeArrays(...arrays) {
  let jointArray = []

  arrays.forEach(array => {
      jointArray = [...jointArray, ...array]
  })
  const uniqueArray = jointArray.reduce((newArray, item) =>{
      if (newArray.includes(item)){
          return newArray
      } else {
          return [...newArray, item]
      }
  }, [])
  return uniqueArray
}

const computeSchemaUsageSql = (state) => {
  const schemata = state.managedSchemata
  .sort((a,b)=>{
    if ( a.schemaName < b.schemaName ){
      return -1;
    }
    if ( a.schemaName > b.schemaName ){
      return 1;
    }
    return 0;

  })
  .map(s => {
    const rolesToGrantTable = Object.keys(state.tablePolicyAssignments)
    .filter(k => k.split('.')[0] === s.schemaName)
    .reduce(
      (all, tableName) => {
        const tpa = state.tablePolicyAssignments[tableName]
        const policy = state.policies.find(p => p.id === tpa.policyDefinitionId)
        const roles = Object.keys(policy.roleGrants)
        .filter(
          r => {
            // console.log(Object.values(policy.roleGrants[r]), Object.values(policy.roleGrants[r]).indexOf('ALLOWED') > -1)
            return Object.values(policy.roleGrants[r]).indexOf('ALLOWED') > -1
          }
        )
        // console.log(JSON.stringify(policy,0.2))
        return roles.length > 0 ? mergeArrays(all, roles) : all
      }, []
    )

    const rolesToGrantFunction = Object.keys(state.functionPolicyAssignments)
    .filter(k => k.split('.')[0] === s.schemaName)
    .reduce(
      (all, functionName) => {
        const fpa = state.functionPolicyAssignments[functionName]
        const policy = state.functionPolicies.find(p => p.id === fpa.policyDefinitionId)
        const roles = Object.keys(policy.roleFunctionGrants)
        .filter(
          r => {
            // console.log(Object.values(policy.roleGrants[r]), Object.values(policy.roleGrants[r]).indexOf('ALLOWED') > -1)
            return Object.values(policy.roleFunctionGrants[r]).indexOf('ALLOWED') > -1
          }
        )
        // console.log(JSON.stringify(policy,0.2))
        return roles.length > 0 ? mergeArrays(all, roles) : all
      }, []
    )
    const rolesToRevoke = [state.roleSet.dbAuthenticatorRole, ...state.roleSet.dbUserRoles]
    const rolesToGrant = mergeArrays(rolesToGrantTable, rolesToGrantFunction).join(', ')
    return {
      ...s,
      appAuthenticator: state.roleSet.dbAuthenticatorRole.roleName,
      rolesToRevoke: rolesToRevoke,
      rolesToGrant: rolesToGrant
    }
  })
  
  return Mustache.render(
    schemaUsageSqlTemplate,
    {
      schemata: schemata,
      appAuthenticator: state.roleSet.dbAuthenticatorRole.roleName
    }
  )
}

export default computeSchemaUsageSql