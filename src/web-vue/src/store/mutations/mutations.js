const defaultRoleGrants = {
  all: 'DENIED',
  select: 'DENIED',
  insert: 'DENIED',
  update: 'DENIED',
  delete: 'DENIED',
}

const defaultRlsQualifiers = {
  all: {
    policies: []
  },
  select: {
    policies: []
  },
  insert: {
    policies: []
  },
  update: {
    policies: []
  },
  delete: {
    policies: []
  }
}

import initialize from './initialize'
import resetDefaultState from './resetDefaultState'
import rawSchemata from './rawSchemata'
import setManagedSchemata from './setManagedSchemata'
import assignTablePolicy from './assignTablePolicy'
import projectRoles from './projectRoles'
import selectedRoleFamilies from './selectedRoleFamilies'
import defaultRlsUsing from './defaultRlsUsing'
import defaultRlsWithCheck from './defaultRlsWithCheck'
import newPolicy from './newPolicy'
import savePolicy from './savePolicy'
import createRlsPolicy from './createRlsPolicy'
import deleteRlsPolicy from './deleteRlsPolicy'

export default {
  initialize,
  resetDefaultState,
  rawSchemata,
  setManagedSchemata,
  assignTablePolicy,
  projectRoles,
  selectedRoleFamilies,
  defaultRlsUsing,
  defaultRlsWithCheck,
  newPolicy,
  savePolicy,
  createRlsPolicy,
  deleteRlsPolicy
}