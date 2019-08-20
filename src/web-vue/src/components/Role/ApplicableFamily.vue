<template>
  <v-container>
    <h1>{{ applicableFamily.name }}</h1>
    <v-data-table
      :headers="familyHeaders"
      :items="applicableFamily.dataRows"
      item-key="roleName"
      class="text-sm-left"
      show-select
      dense
      disable-pagination
      disable-sort
      hide-default-footer
      :value="selected"
      @input="itemSelected"
    >
      <template slot="items" slot-scope="props">
        <tr>
          <td class="" key="grantee">{{ props.item.roleName }}</td>
          <td class="" v-for="fieldName in family.allMemberNames" :key="fieldName">{{ props.item[fieldName] }}</td>
        </tr>
      </template>
    </v-data-table>
  </v-container>
</template>

<script>
  const NOT_ROLE = '---'
  const INHERITS_ROLE = '+++'

  export default {
    name: 'ApplicableFamily',
    mixins: [],
    props: {
      applicableFamily: {
        type: Object,
        required: true
      }
    },
    computed: {
      familyHeaders () {
        const headers = this.applicableFamily.allMemberNames.map(
          memberName => {
            return {
              text: memberName,
              value: memberName,
              sortable: false
            }
          }
        )
        const allHeaders = [{ text: 'grantee', name: 'roleName', value: 'roleName', sortable: false }].concat(headers)
        return allHeaders
      },
      projectRoles () {
        return this.$store.state.projectRoles;
      },
      selected () {
        return this.projectRoles.filter(pr => this.applicableFamily.allMemberNames.indexOf(pr.roleName) !== -1 )
      }
    },
    watch: {
    },
    data: () => ({
      // selected: []
    }),
    methods: {
      itemSelected (selectedItems) {
        const newProjectRoles = [
          ...this.projectRoles.filter(pr => this.applicableFamily.allMemberNames.indexOf(pr.roleName) === -1 )
          ,...selectedItems
        ]
        this.$store.commit('projectRoles', { projectRoles: newProjectRoles })
      }
    },
    mounted () {
    }
  }
</script>

<style>

</style>
