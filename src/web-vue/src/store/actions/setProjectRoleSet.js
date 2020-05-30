async function setProjectRoleSet({commit}, roleSet) {
  await commit('resetDefaultState')
  await commit('setProjectRoleSet', roleSet)
  return `role set set - ${roleSet}`
}

export default setProjectRoleSet;
