import assignTablePolicy from './assignTablePolicy'
import assignFunctionPolicy from './assignFunctionPolicy'
// import evaluateAll from './evaluate/evaluateAll'
// import evaluateUdtScripts from './evaluate/evaluateUdtScripts';

let idSeed = 1
function makeId(){
  idSeed = idSeed + 1
  return ((new Date().getTime() * (10000+idSeed)) + 621355968000000000)
}

function ensureDefaultTablePolicy(state) {
  if (!state.defaultPolicy) {
    const defaultPolicy = {
      id: makeId(),
      name: 'Default Profile - NO ACCESS',
      policyHeaderTemplate: state.policyHeaderTemplate,
      policyFooterTemplate: state.policyFooterTemplate,
      enableRls: true,
      columnExclusionOverrides: {
        insert: [],
        update: [],
      },
      columnExclusions: {
        insert: {},
        update: {},
      },
      roleGrants: state.roleSet.dbUserRoles.reduce((all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]: state.defaultRoleGrants,
        };
      }, {}),
      rlsQualifiers: state.roleSet.dbUserRoles.reduce((all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]: state.defaultRlsQualifiers,
        };
      }, {}),
    };

    state.defaultPolicy = defaultPolicy;
    state.policies = state.policies.concat([defaultPolicy]);
  }
}

function ensureDefaultTablePolicyPermissive(state) {
  if (!state.defaultPolicyPermissive) {
    const defaultPolicyPermissive = {
      id: makeId(),
      name: 'Default Profile - TOTAL EXPLICIT USER ACCESS',
      policyHeaderTemplate: state.policyHeaderTemplate,
      policyFooterTemplate: state.policyFooterTemplate,
      enableRls: false,
      columnExclusionOverrides: {
        insert: [],
        update: [],
      },
      columnExclusions: {
        insert: {},
        update: {},
      },
      roleGrants: state.roleSet.dbUserRoles.reduce((all, projectRole) => {
        if (projectRole.isAnonymous) {
          return {
            ...all,
            [projectRole.roleName]: state.defaultRoleGrants
          }

        } else {
          return {
            ...all,
            [projectRole.roleName]: state.defaultPermissiveRoleGrants,
          };
        }
      }, {}),
      rlsQualifiers: state.roleSet.dbUserRoles.reduce((all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]: state.defaultRlsQualifiers,
        };
      }, {}),
    };

    state.defaultPolicyPermissive = defaultPolicyPermissive;
    state.policies = state.policies.concat([defaultPolicyPermissive]);
  }
}

function ensureDefaultDbUserTablePolicies(state) {
  if (state.defaultDbUserPolicies.length === 0) {
    const defaultDbUserTablePolicies = state.roleSet.dbUserRoles.map(
      dbUserRole => {
        return {
          id: makeId(),
          name: `Default Profile - ${dbUserRole.roleName}`,
          policyHeaderTemplate: state.policyHeaderTemplate,
          policyFooterTemplate: state.policyFooterTemplate,
          enableRls: false,
          columnExclusionOverrides: {
            insert: [],
            update: [],
          },
          columnExclusions: {
            insert: {},
            update: {},
          },
          roleGrants: state.roleSet.dbUserRoles.reduce((all, projectRole) => {
            let roleGrants
            if (projectRole.roleName === dbUserRole.roleName) {
              roleGrants = state.defaultPermissiveRoleGrants
            } else if (projectRole.applicableRoles.map(ar=>ar.roleName).indexOf(dbUserRole.roleName) > -1) {
              roleGrants = state.defaultImpliedRoleGrants
            } else {
              roleGrants = state.defaultRoleGrants
            }

            return {
              ...all,
              [projectRole.roleName]: roleGrants,
            };
        }, {}),
          rlsQualifiers: state.roleSet.dbUserRoles.reduce((all, projectRole) => {
            return {
              ...all,
              [projectRole.roleName]: state.defaultRlsQualifiers,
            };
          }, {}),
        }
      }
    )

    state.defaultDbUserTablePolicies = defaultDbUserTablePolicies;
    state.policies = state.policies.concat(defaultDbUserTablePolicies);
  }
}

function ensureDefaultFunctionPolicy(state) {
  if (!state.defaultFunctionPolicy) {
    const defaultFunctionPolicy = {
      id: makeId(),
      name: 'Default Function Policy - NO ACCESS',
      functionPolicyHeaderTemplate: state.functionPolicyHeaderTemplate,
      functionPolicyFooterTemplate: state.functionPolicyFooterTemplate,
      roleFunctionGrants: state.roleSet.dbUserRoles.reduce((all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]: state.defaultFunctionRoleGrants,
        };
      }, {}),
    };

    state.defaultFunctionPolicy = defaultFunctionPolicy;
    state.functionPolicies = state.functionPolicies.concat([
      defaultFunctionPolicy,
    ]);
  }
}

function ensureDefaultDbUserFunctionPolicies(state) {
  if (state.defaultDbUserPolicies.length === 0) {
    const defaultDbUserFunctionsPolicies = state.roleSet.dbUserRoles.map(
      dbUserRole => {
        return {
          id: makeId(),
          name: `User Function Policy - ${dbUserRole.roleName}`,
          functionPolicyHeaderTemplate: state.functionPolicyHeaderTemplate,
          functionPolicyFooterTemplate: state.functionPolicyFooterTemplate,
          roleFunctionGrants: state.roleSet.dbUserRoles.reduce((all, projectRole) => {
            let roleGrants
            if (projectRole.roleName === dbUserRole.roleName) {
              roleGrants = state.defaultFunctionRoleGrantsPermissive
            } else if (projectRole.applicableRoles.map(ar=>ar.roleName).indexOf(dbUserRole.roleName) > -1) {
              roleGrants = state.defaultFunctionRoleGrantsImplied
            } else {
              roleGrants = state.defaultFunctionRoleGrants
            }

            return {
              ...all,
              [projectRole.roleName]: roleGrants,
            };
          }, {}),
        };
      }
    )

    state.defaultDbUserFunctionsPolicies = defaultDbUserFunctionsPolicies;
    state.functionPolicies = state.functionPolicies.concat(defaultDbUserFunctionsPolicies);

  }
}

function assignMissingDefaultTablePolicies(state, schemata) {
  const tableIds = schemata.reduce(
    (all, schema) => {
      return [
        ...all
        ,...schema.schemaTables.filter(t => state.tablePolicyAssignments[t.id] === undefined).map(t => t.id)
      ]
    }, []
  )

  assignTablePolicy(state, {
    tableIds: tableIds
    ,policyDefinitionId: state.defaultPolicy.id
  })
}

function assignMissingDefaultFunctionPolicies(state, schemata) {
  const functionIds = schemata.reduce(
    (all, schema) => {
      return [
        ...all
        ,...schema.schemaFunctions.filter(f => state.functionPolicyAssignments[f.id] === undefined).map(f => f.id)
      ]
    }, []
  )

  assignFunctionPolicy(state, {
    functionIds: functionIds
    ,policyDefinitionId: state.defaultFunctionPolicy.id
  })

} 

function setManagedSchemata(state, payload) {
  // console.log('sms', payload)
  ensureDefaultTablePolicy(state)
  ensureDefaultTablePolicyPermissive(state)
  ensureDefaultDbUserTablePolicies(state)
  ensureDefaultFunctionPolicy(state)
  ensureDefaultDbUserFunctionPolicies(state)
  assignMissingDefaultTablePolicies(state, payload)
  assignMissingDefaultFunctionPolicies(state, payload)

  state.managedSchemata = payload
  .sort((a,b)=>{
    if ( a.schemaName < b.schemaName ){
      return -1;
    }
    if ( a.schemaName > b.schemaName ){
      return 1;
    }
    return 0;

  })

  // evaluateAll(state)

  state.isDirty = true
  state.initializing = false;
  state.schemaFilterOn = false;
}

export default setManagedSchemata;
