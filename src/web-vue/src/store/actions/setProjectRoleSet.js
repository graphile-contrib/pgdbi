
async function setProjectRoleSet({commit, dispatch}, roleSet) {
  await dispatch('resetDefaultState')
  await commit('setProjectRoleSet', roleSet)
  return `role set set - ${roleSet}`
}

export default setProjectRoleSet;
