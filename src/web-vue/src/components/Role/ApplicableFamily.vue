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
      <template v-slot:item.ignore="{ item }">
        <ignore-role :role="item"></ignore-role>
      </template>

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
  import IgnoreRole from './IgnoreRole'

  export default {
    name: 'ApplicableFamily',
    mixins: [],
    components: {
      IgnoreRole
    },
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

        const allHeaders = [
          { 
            text: 'select family',
            name: 'roleName',
            value: 'roleName', 
            sortable: false 
          },
          {
            text: 'ignore',
            value: 'ignore'
          },
          ,...headers
        ]
        
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
      debounce: false
    }),
    methods: {
      itemSelected (selectedItems) {
        const newProjectRoles = [
          ...this.projectRoles.filter(pr => this.applicableFamily.allMemberNames.indexOf(pr.roleName) === -1 )
          ,...selectedItems.map(i => this.applicableFamily.members.find(m => m.roleName === i.roleName))
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
