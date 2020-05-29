import computeRolesSql from "./computeRolesSql"
import computeSchemaUsageSql from "./computeSchemaUsageSql"
import computeMasterTablePolicy from "./computeMasterTablePolicy"
import computeMasterFunctionPolicy from "./computeMasterFunctionPolicy"
import computeOwnershipPolicy from "./computeOwnershipPolicy"

function computeMasterSecurityPolicy (state, policyReadability) {
  return [
    '--=====  BEGIN COMPLETE SECURITY POLICY -========',
    computeRolesSql(state),
    '\n\n--*****  BEGIN OWNERSHIP -********',
    computeOwnershipPolicy(state, policyReadability),
    '--*****  END OWNERSHIP -**********',
    '\n\n--*****  BEGIN SCHEMA USAGE -********',
    computeSchemaUsageSql(state, policyReadability),
    '--*****  END SCHEMA USAGE -**********',
    '\n\n--*****  BEGIN TABLE POLICIES -********',
    computeMasterTablePolicy(state, policyReadability).policy,
    '--*****  END TABLE POLICIES -**********',
    '\n\n--*****  BEGIN FUNCTION POLICIES -********',
    computeMasterFunctionPolicy(state, policyReadability).policy,
    '--*****  END FUNCTION POLICIES -**********',
    '\n\n--=====  END COMPLETE SECURITY POLICY -==========',
  ].join('\n')

}

export default computeMasterSecurityPolicy