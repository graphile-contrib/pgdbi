import assignTablePolicy from './assignTablePolicy'
import assignFunctionPolicy from './assignFunctionPolicy'
import evaluateAll from './evaluate/evaluateAll'
// import evaluateUdtScripts from './evaluate/evaluateUdtScripts';

function ensureDefaultTablePolicy(state) {
  if (!state.defaultPolicy) {
    const defaultPolicy = {
      id: new Date().getTime() * 10000 + 621355968000000000,
      name: 'Default Table Policy - NO ACCESS',
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
      roleGrants: state.dbUserRoles.reduce((all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]: state.defaultRoleGrants,
        };
      }, {}),
      rlsQualifiers: state.dbUserRoles.reduce((all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]: state.defaultRlsQualifiers,
        };
      }, {}),
    };

    state.defaultPolicy = defaultPolicy;
    state.policies = state.policies.concat([defaultPolicy]);
  }

  if (!state.defaultPolicyPermissive) {
    const defaultPolicyPermissive = {
      id: new Date().getTime() * 10001 + 621355968000000000,
      name: 'Default Table Policy - TOTAL EXPLICIT USER ACCESS',
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
      roleGrants: state.dbUserRoles.reduce((all, projectRole) => {
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
      rlsQualifiers: state.dbUserRoles.reduce((all, projectRole) => {
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

function ensureDefaultFunctionPolicy(state) {
  if (!state.defaultFunctionPolicy) {
    const defaultFunctionPolicy = {
      id: new Date().getTime() * 10000 + 621355968000000000,
      name: 'Default Function Policy - NO ACCESS',
      functionPolicyHeaderTemplate: state.functionPolicyHeaderTemplate,
      functionPolicyFooterTemplate: state.functionPolicyFooterTemplate,
      roleFunctionGrants: state.dbUserRoles.reduce((all, projectRole) => {
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
  ensureDefaultTablePolicy(state)
  ensureDefaultFunctionPolicy(state)
  assignMissingDefaultTablePolicies(state, payload)
  assignMissingDefaultFunctionPolicies(state, payload)

  state.managedSchemata = payload
  
  evaluateAll(state)

  state.initializing = false;
  state.schemaFilterOn = false;
}

export default setManagedSchemata;
