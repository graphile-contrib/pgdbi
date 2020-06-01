function selectedRoleFamilies(state, payload) {
  state.isDirty = true
  state.selectedRoleFamilies = payload.selectedRoleFamilies;
}

export default selectedRoleFamilies;
