function ensureDefaultTablePolicy(state) {
  if (!state.defaultPolicy) {
    const defaultPolicy = {
      id: new Date().getTime() * 10000 + 621355968000000000,
      name: 'Default Table Policy - NO ACCESS',
      policyHeaderTemplate: state.policyHeaderTemplate,
      policyFooterTemplate: state.policyFooterTemplate,
      roleTableGrantTemplate: state.roleTableGrantTemplate,
      enableRls: false,
      columnExclusionOverrides: {
        insert: [],
        update: [],
      },
      columnExclusions: {
        insert: {},
        update: {},
      },
      roleGrants: state.projectRoles.reduce((all, projectRole) => {
        return {
          ...all,
          [projectRole.roleName]: state.defaultRoleGrants,
        };
      }, {}),
      rlsQualifiers: state.projectRoles.reduce((all, projectRole) => {
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

function ensureDefaultFunctionPolicy(state) {
  if (!state.defaultFunctionPolicy) {
    const defaultFunctionPolicy = {
      id: new Date().getTime() * 10000 + 621355968000000000,
      name: 'Default Function Policy - NO ACCESS',
      functionPolicyHeaderTemplate: state.functionPolicyHeaderTemplate,
      functionPolicyFooterTemplate: state.functionPolicyFooterTemplate,
      roleFunctionGrants: state.projectRoles.reduce((all, projectRole) => {
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
  state.tablePolicyAssignments = schemata
    .reduce(
      (all, schema) => {

        const schemaTableAssignments = schema.schemaTables.reduce(
          (all, table) => {
            return {
              ...all,
              [table.id]: state.tablePolicyAssignments[table.id] || state.defaultPolicy.id
            }
          }, {}
        )

        return {
          ...all
          ,...schemaTableAssignments
        }
      }, {}
    )
}

function assignMissingDefaultFunctionPolicies(state, schemata) {
  state.functionPolicyAssignments = schemata
    .reduce(
      (all, schema) => {

        const schemaFunctionAssignments = schema.schemaFunctions.reduce(
          (all, aFunction) => {
            return {
              ...all,
              [aFunction.id]: state.functionPolicyAssignments[aFunction.id] || state.defaultFunctionPolicy.id
            }
          }, {}
        )

        return {
          ...all
          ,...schemaFunctionAssignments
        }
      }, {}
    )
}

function setManagedSchemata(state, payload) {
  ensureDefaultTablePolicy(state)
  ensureDefaultFunctionPolicy(state)
  assignMissingDefaultTablePolicies(state, payload)
  assignMissingDefaultFunctionPolicies(state, payload)

  state.managedSchemata = payload
  state.initializing = false;
  state.schemaFilterOn = false;
}

export default setManagedSchemata;
