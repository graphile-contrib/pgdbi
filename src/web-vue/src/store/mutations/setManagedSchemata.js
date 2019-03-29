function setManagedSchemata (state, payload) {
  const defaultPolicy = {
    id: (((new Date()).getTime() * 10000) + 621355968000000000),
    name: 'Default Policy',
    policyHeaderTemplate: state.policyHeaderTemplate,
    policyFooterTemplate: state.policyFooterTemplate,
    roleTableGrantTemplate: state.roleTableGrantTemplate,
    enableRls: true,
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

  if (!state.defaultPolicy) {
    state.defaultPolicy = defaultPolicy
    state.policies = state.policies.concat([defaultPolicy])
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
        )
      }          
    }
  )
  state.managedSchemata = schemataToUnPark.concat(newlyManagedSchemata).concat(schemataToRemainManaged)
  state.parkedSchemata = schemataToPark.concat(schemataToRemainParked)
  state.initializing = false
}

export default setManagedSchemata