<template>
  <v-container>
    <v-radio-group :value='roleSetId' @change="changeRoleSet" row :disabled="!initializing">
      <v-radio
        v-for="rs in allRoleSets"
        :key="rs.name"
        :label="rs.name"
        :value="rs.name"
      ></v-radio>
    </v-radio-group>

    <v-data-table
      :items="mappedDbUsers"
      :headers="userHeaders"
      hide-default-footer
      disable-sort
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
    watch: {
    },
    computed: {
      allRoleSets () {
        return this.$store.state.allRoleSets
      },
      roleSetId () {
        return this.$store.state.roleSet.name
      },
      initializing () {
        return this.$store.state.initializing
      },
      dbOwner () {
        return this.$store.state.roleSet.dbOwnerRole
      },
      dbAuthenticator () {
        return this.$store.state.roleSet.dbAuthenticatorRole
      },
      dbUsers () {
        const dbUserRoles = this.$store.state.roleSet.dbUserRoles
        return [
          this.dbOwner,
          this.dbAuthenticator,
          ...dbUserRoles
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
        // roleSetId: null,
      }
    },
    methods: {
      changeRoleSet (roleSetId) {
        this.$loading = true
        this.$store.dispatch('setProjectRoleSet', roleSetId)
        .then(() => {
          this.$loading = false
        })
        .catch(error => {
          console.error(error)
          this.$loading = false
        })
      }
    },
    mounted () {
    }
  }
</script>

<style>

</style>
