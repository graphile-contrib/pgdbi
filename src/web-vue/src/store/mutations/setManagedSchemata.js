function setManagedSchemata (state, payload) {
  if (!state.defaultPolicy) {
    const defaultPolicy = {
      id: (((new Date()).getTime() * 10000) + 621355968000000000),
      name: 'Default Table Policy - NO ACCESS',
      policyHeaderTemplate: state.policyHeaderTemplate,
      policyFooterTemplate: state.policyFooterTemplate,
      roleTableGrantTemplate: state.roleTableGrantTemplate,
      enableRls: false,
      columnExclusions: {
        insert: {},
        update: {}
      },
      roleGrants: state.projectRoles.reduce(
        (all, projectRole) => {
          return {
            ...all,
            [projectRole.roleName]: state.defaultRoleGrants
          }
        }, {}
      ),
      rlsQualifiers: state.projectRoles.reduce(
        (all, projectRole) => {
          return {
            ...all,
            [projectRole.roleName]: state.defaultRlsQualifiers
          }
        }, {}
      )
    }

    state.defaultPolicy = defaultPolicy
    state.policies = state.policies.concat([defaultPolicy])
  }

  if (!state.defaultFunctionPolicy) {
    const defaultFunctionPolicy = {
      id: (((new Date()).getTime() * 10000) + 621355968000000000),
      name: "Default Function Policy",
      functionPolicyHeaderTemplate: state.functionPolicyHeaderTemplate,
      functionPolicyFooterTemplate: state.functionPolicyFooterTemplate,
      roleFunctionGrants: state.projectRoles.reduce(
        (all, projectRole) => {
          return {
            ...all,
            [projectRole.roleName]: state.defaultFunctionRoleGrants
          }
        }, {}
      )
    }

    state.defaultFunctionPolicy = defaultFunctionPolicy
    state.functionPolicies = state.functionPolicies.concat([defaultFunctionPolicy])
  }

  const schemataToRemainManaged = state.managedSchemata
    .reduce(
      (all, schema) => {
        return payload.find(s => s.id === schema.id) ? all.concat([schema]) : all
      }, []
    )

  const schemataToPark = state.managedSchemata
    .reduce(
      (all, schema) => {
        return payload.find(s => s.id === schema.id) ? all : all.concat([schema])
      }, []
    )

  const schemataToUnPark = state.parkedSchemata
  .reduce(
    (all, schema) => {
      return payload.find(s => s.id === schema.id) ? all.concat([schema]) : all
    }, []
  )

  const schemataToRemainParked = state.parkedSchemata
  .reduce(
    (all, schema) => {
      return schemataToUnPark.find(s => s.id === schema.id) ? all : all.concat([schema])
    }, []
  )

  const newlyManagedSchemata = payload.reduce(
    (all, schema) => {
      return schemataToUnPark.concat(schemataToRemainManaged).find(s => s.id === schema.id) ? all : all.concat([schema])
    }, []
  ).map(
    schema => {
      return {
        ...schema,
        schemaTables: schema.schemaTables.map(
          table => {
            return {
              ...table,
              policyDefinitionId: table.policyDefinitionId || state.defaultPolicy.id
            }
          }
        ),
        schemaFunctions: schema.schemaFunctions.map(
          theFunction => {
            return {
              ...theFunction,
              functionPolicyDefinitionId: theFunction.functionPolicyDefinitionId || state.defaultFunctionPolicy.id
            }
          }
        )
      }          
    }
  )
  state.managedSchemata = schemataToUnPark.concat(newlyManagedSchemata).concat(schemataToRemainManaged)
  state.parkedSchemata = schemataToPark.concat(schemataToRemainParked)
  state.initializing = false
  state.schemaFilterOn = false
}

export default setManagedSchemata