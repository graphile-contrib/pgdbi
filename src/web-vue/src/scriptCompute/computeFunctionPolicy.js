  import Mustache from 'mustache'
  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'
  const TERSE = 'terse'
  const ALL = 'all'

  // templates for policy calculation -- this could be pushed into the defaultState and made configurable
  // not sure if it would be best to go that route, or to just refine this to an ideal form

  // security removal
  const securityRemovalHeaderTemplate = `
-------------- REMOVE EXISTING FUNCTION GRANTS ----------------------

revoke all privileges on function {{schemaName}}.{{functionName}} from public;
`

  // function grants
  const functionGrantsHeaderTemplate = `
-------------- CREATE NEW TABLE GRANTS ----------------------

`
  const revokeFunctionPrivilegesFromRoleTemplate = `revoke all privileges on function {{schemaName}}.{{functionName}} from {{roleName}};\n`

  const grantActionOnFunctionToRoleTemplate = `grant {{action}} on function {{schemaName}}.{{functionName}} to {{roleName}};\n`
  const implyGrantActionOnFunctionToRoleTemplate = `-- IMPLIED:  grant {{action}} on function {{schemaName}}.{{functionName}} to {{roleName}};\n`
  const denyGrantActionOnFunctionToRoleTemplate = `-- DENIED:  grant {{action}} on function {{schemaName}}.{{functionName}} to {{roleName}};\n`

  function applyTemplate(template, variables) {
    return Object.keys(variables).reduce(
      (result, variableName) => {
        return result.split(`{{${variableName}}}`).join(variables[variableName])
      }, template
    )
  }
  // end of template stuff

function computeFunctionPolicy (policyDefinition, policyReadability, variables, aFunction) {
  const allRoles = Object.keys(policyDefinition.roleFunctionGrants).map(
    roleName => {
      return {
        roleName: roleName
      }
    }
  )

  const revokeRolesList = `${allRoles.map(r => r.roleName).join(', ')}`

  const allowedRoleGrants = Object.keys(policyDefinition.roleFunctionGrants).reduce(
    (allowedRoleGrants, roleName) => {
      if (policyDefinition.roleFunctionGrants[roleName].execute === 'ALLOWED') {
        return allowedRoleGrants.concat([{roleName: roleName}])
      } else {
        return allowedRoleGrants
      }

    }, []
  )

  const impliedRoleGrants = Object.keys(policyDefinition.roleFunctionGrants).reduce(
    (impliedRoleGrants, roleName) => {
      if (policyDefinition.roleFunctionGrants[roleName].execute === 'IMPLIED') {
        return impliedRoleGrants.concat([{roleName: roleName}])
      } else {
        return impliedRoleGrants
      }

    }, []
  )

  const deniedRoleGrants = Object.keys(policyDefinition.roleFunctionGrants).reduce(
    (deniedRoleGrants, roleName) => {
      if (policyDefinition.roleFunctionGrants[roleName].execute === 'DENIED') {
        return deniedRoleGrants.concat([{roleName: roleName}])
      } else {
        return deniedRoleGrants
      }

    }, []
  )

  const verboseVariables = {
    verbose: true,
    deniedRoleGrants: deniedRoleGrants,
    impliedRoleGrants: impliedRoleGrants
  }

  const signatureArgumentDataTypes = aFunction ? aFunction.argumentDataTypes
    .split(',')
    .map(adt => adt.replace('timestamp with time zone', 'timestamptz'))
    .map(adt => adt.trim().split(' ')[1])
    .join(',') : undefined

  const regularVariables = {
    ...variables,
    policyName: policyDefinition.name,
    allowedRoleGrants: allowedRoleGrants,
    revokeRolesList: revokeRolesList,
    functionSignature: aFunction ? `${aFunction.functionSchema}.${aFunction.functionName} (${signatureArgumentDataTypes})` : `{{schemaName}}.{{functionName}} ({{signatureArgumentDataTypes}})`
  }

  const templateVariables = policyReadability === TERSE ? regularVariables : {...verboseVariables, ...regularVariables}

  return Mustache.render(
    functionPolicyTemplate,
    templateVariables
  )
}

export default computeFunctionPolicy

const functionPolicyTemplate = `
----------
----------  BEGIN FUNCTION POLICY: {{functionSignature}}
----------  POLICY NAME:  {{policyName}}
----------

----------  REMOVE EXISTING FUNCTION GRANTS

  revoke all privileges 
  on function {{functionSignature}} 
  from public;

  revoke all privileges 
  on function {{functionSignature}} 
  from {{revokeRolesList}};

----------  CREATE NEW FUNCTION GRANTS
{{#allowedRoleGrants}}

----------  {{roleName}}
  grant 
  execute
  on function {{functionSignature}} 
  to {{roleName}};

{{/allowedRoleGrants}}
{{#verbose}}
----------  IMPLIED FUNCTION GRANTS
  {{#impliedRoleGrants}}
  --IMPLIED:   grant execute on function {{functionSignature}} to {{roleName}};
  {{/impliedRoleGrants}}

  ----------  DENIED TABLE GRANTS
  {{#deniedRoleGrants}}
  --DENIED:   grant execute on function {{functionSignature}} to {{roleName}};
  {{/deniedRoleGrants}}
{{/verbose}}
----------  END FUNCTION POLICY: {{functionSignature}}
--==

`
