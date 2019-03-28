function createRlsPolicy (state, payload) {
  const policy = state.policies.find(p => p.id === payload.policyId)
  const otherPolicies = state.policies.filter(p => p.id !== payload.policyId)
  const roleName = payload.roleName
  const action = payload.action
  
  const id = (((new Date()).getTime() * 10000) + 621355968000000000)
  const newRlsPolicy = {
    id: id
    ,name: payload.name || `rls_${id}`
    ,using: payload.using || state.defaultRlsUsing
    ,withCheck: payload.withCheck || state.defaultRlsWithCheck
    ,passStrategy: payload.passStrategy || 'permissive'
  }

  const updatedPolicy = {
    ...policy,
    rlsQualifiers: {
      ...policy.rlsQualifiers,
      [roleName]: {
        ...policy.rlsQualifiers[roleName],
        [action]: {
          ...policy.rlsQualifiers[roleName][action],
          policies: [
            ...policy.rlsQualifiers[roleName][action].policies,
            ...[newRlsPolicy]
          ]
        }
      }
    }
  }

  state.policies = [...otherPolicies, ...[updatedPolicy]]
}

export default createRlsPolicy