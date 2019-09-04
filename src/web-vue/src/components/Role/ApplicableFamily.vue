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
      },
      maxFamilySize: {
        type: Number,
        required: true
      }
    },
    computed: {
      familyHeaders () {
        const headerWidth = `${100/(this.maxFamilySize + 2)}%`

        const headers = this.applicableFamily.allMemberNames.map(
          memberName => {
            return {
              text: memberName,
              value: memberName,
              sortable: false,
              width: headerWidth
            }
          }
        )

        const placeHolders = new Array(this.maxFamilySize - this.applicableFamily.members.length).fill({
          text: '',
          width: headerWidth
        })

        const allHeaders = [
          { 
            text: 'select family',
            name: 'roleName',
            value: 'roleName', 
            sortable: false,
            width: headerWidth
          },
          {
            text: 'ignore',
            value: 'ignore',
            width: headerWidth
          },
          ,...headers,
          ...placeHolders,
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
