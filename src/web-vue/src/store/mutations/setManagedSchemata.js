import assignTablePolicy from './assignTablePolicy'
import assignFunctionPolicy from './assignFunctionPolicy'
const NO_INDEX = 'NO INDEX'
const MULTIPLE_INDICES = 'MULTIPLE_INDICES'

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

function evaluateFkIndexes(state) {
  const evaluations = state.managedSchemata
    .reduce(
      (all, schema) => {
        return {
          ...all
          ,...schema.schemaTables.reduce(
            (all, table) => {
              const fkColumnEvaluations = (table.tableColumns || [])
              .reduce(
                (all, c) => {
                  const columnIndices = table.indices.filter(i => i.tableSchema === c.tableSchema && i.tableName === c.tableName && i.columnName === c.columnName)
                  // foreign keys
                  const fkConstraintUsage = (table.referentialConstraints || [])
                    .filter(
                      rc => {
                        return rc.referencingColumnUsage.find(rcu => rcu.tableSchema === c.tableSchema && rcu.tableName === c.tableName && rcu.columnName === c.columnName) !== undefined
                      }
                    )
                    .map(
                      rc => {
                        const fkIndexEvaluation = columnIndices.length == 0 ? NO_INDEX : (columnIndices.length > 1 ? MULTIPLE_INDICES : columnIndices[0].indexName)
                        const rcu = rc.referencedColumnUsage[0]
                        return {
                          constraintName: rc.constraintName,
                          fkPath: `${rcu.tableSchema}.${rcu.tableName}.${rcu.columnName}`,
                          fkIndices: columnIndices,
                          fkIndexEvaluation: fkIndexEvaluation,
                          fkTableLinkId: `${rcu.tableSchema}.${rcu.tableName}`
                        }
                      }
                    )
      
                  if (fkConstraintUsage.length > 0) {
                    return {
                      ...all
                      ,[c.id]: fkConstraintUsage
                    }  
                  } else {
                    return all
                  }
                }, {}
              )
    
              return {
                ...all
                ,...fkColumnEvaluations
              }
            }, {}
          )
        }
      }, {}
    )

  console.log('fk evaluations', evaluations)
  state.fkIndex = {
    ...state.fkIndex
    ,evaluations: evaluations
  }
}

function evaluateUqIndexes(state) {
  const evaluations = state.managedSchemata
    .reduce(
      (all, schema) => {
        return {
          ...all
          ,...schema.schemaTables.reduce(
            (all, table) => {
              const uqColumnEvaluations = (table.tableColumns || [])
              .reduce(
                (all, c) => {
                  const columnIndices = table.indices.filter(i => i.tableSchema === c.tableSchema && i.tableName === c.tableName && i.columnName === c.columnName)
                  // foreign keys
                  const uqConstraintUsage = (table.uniqueConstraints || [])
                    .filter(
                      rc => {
                        return rc.keyColumnUsage.find(kcu => kcu.tableSchema === c.tableSchema && kcu.tableName === c.tableName && kcu.columnName === c.columnName) !== undefined
                      }
                    )
                    .map(
                      rc => {
                        const uqIndexEvaluation = columnIndices.length == 0 ? NO_INDEX : (columnIndices.length > 1 ? MULTIPLE_INDICES : columnIndices[0].indexName)
                        const kcu = rc.keyColumnUsage[0]
                        return {
                          constraintName: rc.constraintName,
                          uqPath: `${kcu.tableSchema}.${kcu.tableName}.${kcu.columnName}`,
                          uqIndices: columnIndices,
                          uqIndexEvaluation: uqIndexEvaluation,
                        }
                      }
                    )
      
                  if (uqConstraintUsage.length > 0) {
                    return {
                      ...all
                      ,[c.id]: uqConstraintUsage
                    }  
                  } else {
                    return all
                  }
                }, {}
              )
    
              return {
                ...all
                ,...uqColumnEvaluations
              }
            }, {}
          )
        }
      }, {}
    )

  console.log('uq evaluations', evaluations)
  state.uqIndex = {
    ...state.uqIndex
    ,evaluations: evaluations
  }
}

function setManagedSchemata(state, payload) {
  ensureDefaultTablePolicy(state)
  ensureDefaultFunctionPolicy(state)
  assignMissingDefaultTablePolicies(state, payload)
  assignMissingDefaultFunctionPolicies(state, payload)

  state.managedSchemata = payload
  
  evaluateFkIndexes(state)
  evaluateUqIndexes(state)

  state.initializing = false;
  state.schemaFilterOn = false;
}

export default setManagedSchemata;
