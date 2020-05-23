<template>
  <v-container>
    <v-row>
      <v-col>
        <h2>Owner</h2>
        <v-data-table
          :items="dbOwners"
          :headers="headers"
          hide-default-footer
        >
        </v-data-table>
      </v-col>
      <v-col>
        <h2>Authenticator</h2>
        <v-data-table
          :items="dbAuthenticators"
          :headers="headers"
          hide-default-footer
        >
        </v-data-table>
      </v-col>
      <v-col>
        <h2>Anonymous</h2>
        <v-data-table
          :items="dbAnonymouses"
          :headers="headers"
          hide-default-footer
        >
        </v-data-table>
      </v-col>
    </v-row>
    <hr>
    <h2>Users</h2>
    <v-data-table
      :items="mappedDbUsers"
      :headers="userHeaders"
      hide-default-footer
    >
    </v-data-table>
  </v-container>
</template>

<script>
  const NOT_ROLE = '---'
  const INHERITS_ROLE = '+++'

  export default {
    name: 'Roles',
    mixins: [],
    components: {
    },
    computed: {
      dbOwners () {
        return [this.$store.state.dbOwnerRole]
      },
      dbAuthenticators () {
        return [this.$store.state.dbAuthenticatorRole]
      },
      dbAnonymouses () {
        return [this.$store.state.dbAnonymousRole]
      },
      dbUsers () {
        return this.$store.state.dbUserRoles
      },
      userHeaders () {
        return [
          { text: 'name', value: 'name'},
          ... this.dbUsers
            .sort((a,b)=>{
              return b.applicableRoles.length - a.applicableRoles.length
            })
            .map(
              r => {
                return { text: r.roleName, value: r.roleName }
              }
            )
        ]        
      },
      mappedDbUsers () {
        return this.dbUsers.map(
          thisRole => {
            return this.dbUsers.reduce(
              (a, thatRole) => {
                if (thisRole.roleName === thatRole.roleName) {
                  return {
                    ...a,
                    [thatRole.roleName]: thisRole.roleName
                  }
                } else if (thisRole.applicableRoles.indexOf(thatRole.roleName) > -1) {
                  return {
                    ...a,
                    [thatRole.roleName]: INHERITS_ROLE
                  }

                } else {
                  return {
                    ...a,
                    [thatRole.roleName]: NOT_ROLE
                  }

                }
              }, {
                name: thisRole.roleName
              }
            )
          }
        )
      }
    },
    data () {
      return {
          headers: [
          {
            text: 'name',
            value: 'roleName'
          }
        ],
        // dbOwnerRole: {
        //   name: 'app_owner',
        // },
        // dbAuthenticatorRole: {
        //   name: 'app_authenticator',
        // },
        // dbUserRoles: [
        //   {
        //     name: 'app_super_admin',
        //     applicableRoles: [ 'app_admin', 'app_user', 'app_anonymous' ]
        //   },
        //   {
        //     name: 'app_admin',
        //     applicableRoles: [ 'app_user', 'app_anonymous' ]
        //   },
        //   {
        //     name: 'app_user',
        //     applicableRoles: [ 'app_anonymous' ]
        //   },
        //   {
        //     name: 'app_anoymous',
        //     applicableRoles: []
        //   }
        // ],
      }
    },
    methods: {
    }
  }
</script>

<style>

</style>
