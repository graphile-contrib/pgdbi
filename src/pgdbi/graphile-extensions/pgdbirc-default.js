module.exports = {
  allRoleSets: [
    {
      name: 'graphile-visitor',
      defaultRlsUsing: '( user_id = app_public.current_user_id() )',
      dbOwnerRole: {
        roleName: 'graphile_starter',
        applicableRoles: []
      },
      dbAuthenticatorRole: {
        roleName: 'graphile_starter_authenticator',
        applicableRoles: [ {roleName: 'graphile_starter_visitor'} ]
      },
      dbUserRoles: [
        {
          roleName: 'graphile_starter_visitor',
          applicableRoles: [ ]
        }
      ],    
  },
  {
    name: 'app-visitor',
    defaultRlsUsing: '( user_id = app_public.current_user_id() )',
    dbOwnerRole: {
      roleName: 'app_owner',
      applicableRoles: []
    },
    dbAuthenticatorRole: {
      roleName: 'app_authenticator',
      applicableRoles: [ {roleName: 'app_visitor'} ]
    },
    dbUserRoles: [
      {
        roleName: 'app_visitor',
        applicableRoles: [ ]
      }
    ],    
  },
  {
      name: 'postgraphql-classic',
      defaultRlsUsing: '( user_id = app_public.current_user_id() )',
      dbOwnerRole: {
        roleName: 'app_owner',
        applicableRoles: []
      },
      dbAuthenticatorRole: {
        roleName: 'app_authenticator',
        applicableRoles: [ {roleName: 'app_super_admin'}, {roleName: 'app_admin'}, {roleName: 'app_user'}, {roleName: 'app_anonymous'} ]
      },
      dbUserRoles: [
        {
          roleName: 'app_super_admin',
          applicableRoles: [ {roleName: 'app_admin'}, {roleName: 'app_user'}, {roleName: 'app_anonymous'} ]
        },
        {
          roleName: 'app_admin',
          applicableRoles: [ {roleName: 'app_user'}, {roleName: 'app_anonymous'} ]
        },
        {
          roleName: 'app_user',
          applicableRoles: [ {roleName: 'app_anonymous'} ]
        },
        {
          roleName: 'app_anonymous',
          applicableRoles: []
        }
      ]
    }
  ]
}
