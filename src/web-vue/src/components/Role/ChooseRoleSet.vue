<template>
  <v-container>
    <v-toolbar>
      <v-row>
        <v-col cols="1">
          <v-tooltip top>
            <template v-slot:activator="{ on, attrs }">
              <v-icon
                v-bind="attrs"
                v-on="on"
                color="blue"
              >mdi-help-circle</v-icon>
            </template>
            <span>role sets can be edited in the following file relative to where pgbi was executed<hr>./.pgdbi/.pgdbirc</span>
          </v-tooltip>
        </v-col>
        <v-col cols="8">
          <v-radio-group :value="roleSetId" @change="changeRoleSet" row :disabled="!initializing">
            <v-radio
              v-for="rs in allRoleSets"
              :key="rs.name"
              :label="rs.name"
              :value="rs.name"
            ></v-radio>
          </v-radio-group>
        </v-col>
      </v-row>
    </v-toolbar>

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
  import pgdbirc from '@/gql/query/pgdbirc.graphql'

  export default {
    name: 'Roles',
    mixins: [],
    components: {
    },
    watch: {
    },
    computed: {
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
        allRoleSets: []
      }
    },
    methods: {
      changeRoleSet (roleSetId) {
        this.$store.dispatch('setProjectRoleSet', roleSetId)
        .then(() => {
        })
        .catch(error => {
          console.error(error)
        })
      }
    },
    apollo: {
      init: {
        query: pgdbirc,
        networkPolicy: 'fetchOnly',
        update (data) {
          this.allRoleSets = data.PGDBIRC.pgdbirc.allRoleSets
          if (this.initializing) {
            this.changeRoleSet(this.allRoleSets[0].name)
          }
        }
      }
    }
    // mounted () {
    // }
  }
</script>

<style>

</style>
