function deleteRlsPolicy (state, payload) {
  const policy = state.policies.find(p => p.id === payload.policyId)
  const otherPolicies = state.policies.filter(p => p.id !== payload.policyId)
  const roleName = payload.roleName
  const action = payload.action
  const rlsPolicyId = payload.rlsPolicyId

  const updatedPolicy = {
    ...policy,
    rlsQualifiers: {
      ...policy.rlsQualifiers,
      [roleName]: {
        ...policy.rlsQualifiers[roleName],
        [action]: {
          ...policy.rlsQualifiers[roleName][action],
          policies: policy.rlsQualifiers[roleName][action].policies.filter(rp => rp.id !== rlsPolicyId)
        }
      }
    }
  }

  state.policies = [...otherPolicies, ...[updatedPolicy]]
}

export default deleteRlsPolicy