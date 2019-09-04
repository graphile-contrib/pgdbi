<template>
  <v-container>
    <div v-for="family in roleFamilies" :key="family.name">
      <applicable-family
        :applicableFamily="family"
        :maxFamilySize="maxFamilySize"
      ></applicable-family>
    </div>
 </v-container>
</template>

<script>
  import allEnabledRoles from '@/gql/query/allEnabledRoles.graphql'
  import ApplicableFamily from './ApplicableFamily'
  // const IS_ROLE = '***'
  const NOT_ROLE = '---'
  const INHERITS_ROLE = '+++'

  export default {
    name: 'RoleFilter',
    mixins: [],
    components: {
      ApplicableFamily
    },
    computed: {
      maxFamilySize () {
        return this.roleFamilies.reduce(
          (max, f) => {
            return f.members.length > max ? f.members.length : max
          }, 0
        )

      },
      initializing () {
        return this.$store.state.initializing
      },
      enabledRoles () {
        return this.$store.state.enabledRoles
      },
      projectRoles () {
        return this.$store.state.projectRoles
      },
      applyDisabled () {
        if (this.roles.length > 0) {
          const allFilteredRolesSelected = this.projectRoles.reduce(
            (result, projectRole) => { 
              const role = this.roles.find(r => r.roleName === projectRole.roleName)
              return !result ? result : role.selected
            }, true)


          const selectedRoles = this.roles.filter(r => r.selected)

          return allFilteredRolesSelected && (selectedRoles.length === this.projectRoles.length)
        } else {
          return true
        }
      },
      selectedRoleFamilies () {
        return this.$store.state.selectedRoleFamilies
      }
    },
    watch: {
      initializing () {
        this.computeItems()
      }
    },
    data: () => ({
      roleFamilies: [],
      roles: [],
      checkedFamilies: [],
      checkedRoles: {}
    }),
    methods: {
      computeItems () {
        this.roles.map(
          role => {
            role.selected = this.projectRoles.find(pr => pr.name === role.name) !== undefined
          }
        )

        // determine families by analyzing applicaple roles
        // ideally, 
        const families = this.roles
          // sort so the most senior role is first
          .sort((a,b) => { return a.applicableRoles.length >= b.applicableRoles.length ? -1 : 1})
          .reduce((families, role)=>{
            // find existing family
            const existingFamily = families.find(f => new Set(f.allMemberNames).has(role.roleName))

            if (existingFamily) {
              // todo: add applicable roles from current role to allMemberNames
              return families
            } else {
              const allMemberNames = role.applicableRoles
                .map(r => { return r.roleName })
                .concat([role.roleName])
                .sort(
                  (a,b) => {
                    const alength = this.roles.find(r => r.roleName === a).applicableRoles.length
                    const blength = this.roles.find(r => r.roleName === b).applicableRoles.length
                    return alength >= blength ? -1 : 1 
                  }
                )

              return families.concat([{
                name: role.roleName,
                selected: this.selectedRoleFamilies.find(rf => rf.name === role.roleName),
                allMemberNames: allMemberNames
              }])
            }
          }, [])

        this.roleFamilies = families
          .reduce(
            (rf, family) => {
              const dataRows = family.allMemberNames.reduce(
                (dataRow, roleName) => {
                  const role = this.roles.find(r => r.roleName === roleName)
                  const columns = family.allMemberNames
                    .reduce(
                      (ag, memberName) => {
                        const applicableRole = role.applicableRoles.find(ar => ar.roleName === memberName)
                        if (applicableRole !== undefined) {
                          return Object.assign(ag, {
                            [memberName]: INHERITS_ROLE
                          })
                        } else if (role.roleName === memberName) {
                          return Object.assign(ag, {
                            [memberName]: memberName //IS_ROLE
                          })
                        } else {
                          return Object.assign(ag, {
                            [memberName]: NOT_ROLE
                          })
                        }
                      }, {}
                    )

                  return dataRow.concat([Object.assign({
                    roleName: roleName
                  }, columns)])
                  
                }, []
              )

              const members = this.roles.filter(r => family.allMemberNames.indexOf(r.roleName) > -1)

              return rf.concat([Object.assign(family, { 
                dataRows: dataRows,
                members: members
              })])
          }, []
        )
      },
      familyItems (family) {
        return family.items
      }
    },
    mounted () {
      this.roles = this.enabledRoles.map(
        role => {
          const selected = (this.projectRoles.find(r => r.roleName === role.roleName) !== undefined)
          return {
            ...role,
            selected: (this.projectRoles.find(r => r.roleName === role.roleName) !== undefined)
          }
        }
      )
      this.computeItems()
    }
  }
</script>

<style>

</style>
