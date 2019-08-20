
<template>
    <div>
      <v-dialog v-model="dialog" persistent width="800">
        <template v-slot:activator="{ on }">
          <v-btn
            small
            dark v-on="on"
            class="text-none"
            :disabled="disabled"
          >
            {{ displayValue }}
          </v-btn>
        </template>
        <v-card>
          <v-card-title class="headline">Custom Policy</v-card-title>
          <v-text-field v-model="customName"></v-text-field>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn @click="dialog=false">Cancel</v-btn>
            <v-btn @click="customizeTablePolicyDefinition">Customize</v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
</template>

<script>
  export default {
    name: 'PolicyCustomizeDialog',
    props: {
      currentPolicyDefinition: {
        type: Object,
        required: true
      },
      tables: {
        type: Array,
        required: true
      },
      bulkCustomize: {
        type: Boolean,
        default: false
      },
      disabled: {
        type: Boolean,
        default: false
      }      
    },
    mounted () {
      this.customName = this.defaultCustomName
    },
    data () {
      return {
        dialog: false,
        customName: 'n/a'
      }
    },
    computed: {
      displayValue () {
        if (this.bulkCustomize) {
          return 'Bulk Customize'
        } else {
          return 'Customize'
        }
      },
      defaultCustomName () {
        if (this.tables.length === 1) {
          return `Custom Policy: ${this.tables[0].tableSchema}.${this.tables[0].tableName}`
        } else if (this.tables.length > 1) {
          return 'New Bulk Policy'
        } else {
          return 'n/a'
        }
      }
    },
    watch: {
    },
    methods: {
      customizeTablePolicyDefinition() {
        this.dialog = false
        const tableIds = this.tables.reduce(
          (tableIds, table) => {
            return tableIds.concat([table.id])
          }, []
        )

        this.$store.commit('customizeTablePolicy', {
          sourcePolicyDefinitionId: this.currentPolicyDefinition.id,
          tableIds: tableIds,
          newFields: {
            name: this.customName
          }
        })
      }
    }
  }
</script>

<style>
.norm-text {
  text-transform: none !important;
}
</style>