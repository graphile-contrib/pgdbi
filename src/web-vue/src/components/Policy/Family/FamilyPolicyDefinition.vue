<template>
    <div>
      <h1>Policy Name: {{ policy.name }}</h1>
      <h2>Family Name: {{ family.name }}</h2>
      <v-layout justify-center>
        <v-checkbox v-model="enableRLS" label="Enable RLS"></v-checkbox>
      </v-layout>
      <v-data-table
        :headers="headers"
        :items="items"
        hide-actions
        item-key="id"
        class="text-sm-left"
      >
        <template slot="items" slot-scope="props">
          <tr @click="props.expanded = !props.expanded">
            <td>{{ props.item.roleName }}</td>
            <td><v-checkbox :input-value="props.item.select"></v-checkbox></td>
            <td><v-checkbox :input-value="props.item.insert"></v-checkbox></td>
            <td><v-checkbox :input-value="props.item.update"></v-checkbox></td>
            <td><v-checkbox :input-value="props.item.delete"></v-checkbox></td>
            <td>{{ props.item.qual }}</td>
          </tr>
        </template>
      </v-data-table>
    </div>
</template>

<script>
  export default {
    name: 'PolicyManager',
    props: {
      family: {
        type: Object,
        required: true
      },
      policy: {
        type: Object,
        required: true
      }
    },
    data () {
      return {
        enableRLS: true,
      }
    },
    watch: {
      enableRLS () {
        console.log('this.enableRLS', this.enableRLS)
      }
    },
    computed: {
      defaultRLSQual () {
        return this.$store.state.defaultRLSQual
      },
      headers () {
        const hdrs = [
          {
            text: 'Role Name',
            sortable: false
          },
          {
            text: 'SELECT',
            sortable: false
          },
          {
            text: 'INSERT',
            sortable: false
          },
          {
            text: 'UPDATE',
            sortable: false
          },
          {
            text: 'DELETE',
            sortable: false
          }
        ]

        return !this.enableRLS ? hdrs : hdrs.concat([{
            text: 'RLS Qualifier',
            sortable: false
          }])
      },
      items () {
        return this.family.members.map(
          member => {
            const cols = {
              roleName: member.roleName,
              select: true,
              insert: false,
              update: false,
              delete: false,
            }

            return !this.enableRLS ? cols : Object.assign(cols, {
              qual: this.defaultRLSQual
            })
          }
        )
      }
    }
  }
</script>