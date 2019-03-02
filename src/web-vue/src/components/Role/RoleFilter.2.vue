<template>
  <v-container>
    <div v-for="family in roleFamilies" :key="family.name">
      <v-toolbar>
        <h2>Applicable Family</h2>
        <v-spacer></v-spacer>
        <h2>{{ family.name }}</h2>
        <v-spacer></v-spacer>
      </v-toolbar>
      <v-data-table
        :headers="familyHeaders(family)"
        :items="family.dataRows"
        hide-actions
        item-key="id"
        class="text-sm-left"
      >
        <template slot="items" slot-scope="props">
          <tr @click="props.expanded = !props.expanded">        
            <td>
            </td>
            <td class="text-sm-left">{{ props.item.roleName }}</td>
            <td class="text-sm-left" v-for="fieldName in family.allMemberNames" :key="fieldName">{{ props.item[fieldName] }}</td>
          </tr>
        </template>
      </v-data-table>
      <hr>
    </div>
 </v-container>
</template>

<script>
  import allEnabledRoles from '@/gql/query/allEnabledRoles.graphql'
  import RoleFilterFunctionsMixin from './RoleFilterFunctionsMixin.vue'
  // const IS_ROLE = '***'
  const NOT_ROLE = '---'
  const INHERITS_ROLE = '+++'

  export default {
    name: 'RoleFilter',
    mixins: [RoleFilterFunctionsMixin],
    computed: {
      roleFilter () {
        return this.$store.state.roleFilter
      },
      applyDisabled () {
        if (this.roles.length > 0) {
          const roleFilter = this.roleFilter
          const allFilteredRolesSelected = roleFilter.reduce(
            (result, roleName) => { 
              const role = this.roles.find(r => r.roleName === roleName)
              return !result ? result : role.selected
            }, true)


          const selectedRoles = this.roles.filter(r => r.selected)

          return allFilteredRolesSelected && (selectedRoles.length === roleFilter.length)
        } else {
          return true
        }
      },
      selectedRoleFamilies () {
        return this.$store.state.selectedRoleFamilies
      }
    },
    watch: {
    },
    data: () => ({
      roleFamilies: [],
      roles: [],
      checkedFamilies: [],
      checkedRoles: {}
    }),
    methods: {
      familyHeaders (family) {
        const headers = family.allMemberNames.map(
          memberName => {
            return {
              text: memberName,
              value: memberName,
              sortable: false
            }
          }
        )
        const allHeaders = [{ name: 'checkbox', sortable: false}, { text: 'grantee', name: 'grantee', sortable: false }].concat(headers)
        return allHeaders
      },
      computeItems () {
        this.roles.map(
          role => {
            role.selected = this.roleFilter.indexOf(role.roleName) > -1
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
    apollo: {
      init: {
        query: allEnabledRoles,
        update (result) {
          this.roles = result.allEnabledRoles.nodes.map(
            role => {
              return {
                ...role,
                selected: false
              }
            }
          )
          this.computeItems()
        }
      }
    }
  }
</script>

<style>

</style>
