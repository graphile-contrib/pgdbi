<template>
  <v-container>
    <div v-for="family in roleFamilies" :key="family.name">
      <v-toolbar>
        <v-checkbox 
          @change="familyCheckChanged(family)" 
          :input-value="familyIsSelected(family)"
        ></v-checkbox>
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
              <v-checkbox 
              :input-value="roleIsSelected(props.item)" 
              @change="roleCheckChanged(props.item)"
              ></v-checkbox>
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
  // const IS_ROLE = '***'
  const NOT_ROLE = '---'
  const INHERITS_ROLE = '+++'

  export default {
    name: 'RoleFilter',
    mixins: [],
    computed: {
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
      familyIsSelected (family) {
        const allMembersSelected = family.members.reduce((all, m) => { return !all ? all : this.roleIsSelected(m) }, true)
        return allMembersSelected
      },
      roleIsSelected (role) {
        return  this.projectRoles.find(r => r.roleName === role.roleName) !== undefined
      },
      familyCheckChanged (family) {
        const currentlySelected = this.familyIsSelected(family)
        const projectRoles = currentlySelected
          ? this.projectRoles.filter(r => family.members.find(m => m.roleName === r.roleName) === undefined)
          : Array.from(new Set([...family.members, ...this.projectRoles]))

          this.$store.commit('projectRoles', { projectRoles: projectRoles })
      },
      roleCheckChanged (role) {
        role.selected = !(role.selected)
        const roleIsSelectedAlready = this.projectRoles.find(r => r.roleName === role.roleName)
        const projectRoles = roleIsSelectedAlready
          ? this.projectRoles.filter(r => r.roleName !== role.roleName)
          : [...this.projectRoles, ...[role]]

        this.$store.commit('projectRoles', { projectRoles: projectRoles })
      },
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
            role.selected = this.projectRoles.find(pr => pr.name === role.name) !== undefined
          }
        )

        // determine families by analyzing applicaple roles
        // ideally, 
        console.log('roles', JSON.stringify(this.roles.filter(r => ['app_super_admin', 'app_tenant_admin'].indexOf(r.roleName) > -1), 0, 2))
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
