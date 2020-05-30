async function setProjectRoleSet({commit}, roleSet) {
  await commit('resetDefaultState')
  commit('setProjectRoleSet', roleSet)
}

export default setProjectRoleSet;
