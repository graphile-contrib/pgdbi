import assignTablePolicy from './assignTablePolicy'
import assignFunctionPolicy from './assignFunctionPolicy'
import evaluateFkIndexes from './evaluate/evaluateFkIndexes'
import evaluateUqIndexes from './evaluate/evaluateUqIndexes'
import evaluateGenericIndices from './evaluate/evaluateGenericIndices'
import evaluateEnumScripts from './evaluate/evaluateEnumScripts'

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
  
  evaluateFkIndexes(state)
  evaluateUqIndexes(state)
  evaluateGenericIndices(state)
  evaluateEnumScripts(state)

  state.initializing = false;
  state.schemaFilterOn = false;
}

export default setManagedSchemata;
