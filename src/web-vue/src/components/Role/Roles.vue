<template>
  <v-container>
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
      dbOwner () {
        return this.$store.state.dbOwnerRole
      },
      dbAuthenticator () {
        return this.$store.state.dbAuthenticatorRole
      },
      dbUsers () {
        return [
          this.dbOwner,
          this.dbAuthenticator,
          ...this.$store.state.dbUserRoles
            .sort((a,b)=>{
              return b.applicableRoles.length - a.applicableRoles.length
            }),
        ]
      },
      userHeaders () {
        return [
          { text: 'name', value: 'name'},
          ... this.dbUsers
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
                } else if (thisRole.applicableRoles.map(ar=>ar.roleName).indexOf(thatRole.roleName) > -1) {
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
      }
    },
    methods: {
    }
  }
</script>

<style>

</style>
