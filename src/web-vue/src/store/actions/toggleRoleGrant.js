import savePolicy from "./savePolicy"

const ALLOWED = 'ALLOWED'
const DENIED = 'DENIED'
const IMPLIED = 'IMPLIED'

function toggleRoleGrant(state, payload) {
  const policyDefinition = state.policies.find(p => p.id = payload.policyDefinitionId)
  const dbUserRoles = state.dbUserRoles
  const toggledRoleName = payload.toggledRoleName
  const action = payload.action

  if (!policyDefinition) throw new Error(`No policy definition for id: ${payload.policyDefinitionId}`)
  if (!dbUserRoles) throw new Error(`No dbUserRoles!`)
  if (!toggledRoleName) throw new Error(`No toggledRoleName!`)
  if (!action) throw new Error(`No action!`)

  const currentValue = policyDefinition.roleGrants[toggledRoleName][action]

  const impliedRoleNames = dbUserRoles.filter(
    pr => {
      return (pr.applicableRoles || []).find(ar => ar.roleName === toggledRoleName) !== undefined
    }
  ).reduce((a,r)=>{ return a.concat(r.roleName)}, [])

  const newPolicy = {
    ...policyDefinition,
    roleGrants: Object.keys(policyDefinition.roleGrants).reduce(
      (newGrants, newRoleName) => {
        const toggledRoleIsApplicableToNew = impliedRoleNames.indexOf(newRoleName) > -1
        const newRoleIsToggledRole = newRoleName === toggledRoleName

        return {
          ...newGrants,
          [newRoleName]: Object.keys(policyDefinition.roleGrants[newRoleName]).reduce(
            (newRow, newAction) => {
              const oldValue = policyDefinition.roleGrants[newRoleName][newAction]
              let newValue
              if (newAction === action) {
                if (newRoleIsToggledRole) {
                  newValue = currentValue === ALLOWED ? DENIED : ALLOWED
                } else if (toggledRoleIsApplicableToNew) {
                  newValue = currentValue === ALLOWED ? DENIED : IMPLIED
                } else {
                  newValue = policyDefinition.roleGrants[newRoleName][newAction]
                }
              } else {
                if (newAction == 'all') {
                  if ((toggledRoleIsApplicableToNew || newRoleIsToggledRole) && currentValue === ALLOWED) {
                    newValue = DENIED
                  } else {
                    newValue = policyDefinition.roleGrants[newRoleName][newAction]
                  }
                } else {
                  newValue = policyDefinition.roleGrants[newRoleName][newAction]
                }
              }

              return {
                ...newRow,
                [newAction]: newValue
              }
            }, {}
          )
        }
      }, {}
    )
  }

  console.log('sp', savePolicy)
  savePolicy(state, {policy: newPolicy})
}

export default toggleRoleGrant