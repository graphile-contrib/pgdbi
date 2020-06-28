import resetDefaultState from './resetDefaultState';
import filterSchemata from './filterSchemata';
import setManagedSchemata from './setManagedSchemata';
import assignTablePolicy from './assignTablePolicy';
import defaultRlsUsing from './defaultRlsUsing';
import defaultRlsWithCheck from './defaultRlsWithCheck';
import newPolicy from './newPolicy';
import savePolicy from './savePolicy';
import newFunctionPolicy from './newFunctionPolicy';
import saveFunctionPolicy from './saveFunctionPolicy';
import assignFunctionPolicy from './assignFunctionPolicy';
import createRlsPolicy from './createRlsPolicy';
import deleteRlsPolicy from './deleteRlsPolicy';
import importProject from './importProject';
import customizeTablePolicy from './customizeTablePolicy';
import makeGlobalTablePolicy from './makeGlobalTablePolicy';
import deleteTablePolicy from './deleteTablePolicy';
import updateTablePolicyTemplate from './updateTablePolicyTemplate';
import updateDefaultRlsUsing from './updateDefaultRlsUsing';
import setPgdbiOptions from './setPgdbiOptions'
import renameTablePolicy from './renameTablePolicy'
import setProjectRoleSet from './setProjectRoleSet'
import setAllRoleSets from './setAllRoleSets'
import savePgLintResult from './savePgLintResult'
import setExistingRlsPolicies from './setExistingRlsPolicies'
// import projectRoles from './projectRoles';
// import selectedRoleFamilies from './selectedRoleFamilies';
// import setEnabledRoles from './setEnabledRoles'
// import toggleIgnoreRole from './toggleIgnoreRole'
// import toggleIndexForDrop from './toggleIndexForDrop'

export default {
  resetDefaultState,
  filterSchemata,
  setManagedSchemata,
  assignTablePolicy,
  // projectRoles,
  // selectedRoleFamilies,
  defaultRlsUsing,
  defaultRlsWithCheck,
  newPolicy,
  savePolicy,
  createRlsPolicy,
  deleteRlsPolicy,
  importProject,
  newFunctionPolicy,
  saveFunctionPolicy,
  assignFunctionPolicy,
  customizeTablePolicy,
  makeGlobalTablePolicy,
  deleteTablePolicy,
  updateTablePolicyTemplate,
  updateDefaultRlsUsing,
  // setEnabledRoles,
  // toggleIgnoreRole,
  setPgdbiOptions,
  // toggleIndexForDrop,
  renameTablePolicy,
  setProjectRoleSet,
  setAllRoleSets,
  savePgLintResult,
  setExistingRlsPolicies
};
