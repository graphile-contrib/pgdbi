<template>
    <v-card color="black" :key="policy.id">
      <v-container>
        <v-toolbar>
          <h1>Policy Name: {{ policy.name }}</h1>
          <v-spacer></v-spacer>
          <v-layout justify-center>
            <!-- <v-checkbox :input-value="enableRls" label="Enable Rls" :disabled="disabled" @click="toggleEnableRls" ref="enableRlsCheckbox"></v-checkbox> -->
            <v-checkbox v-model="enableRls" label="Enable Rls" :disabled="disabled"></v-checkbox>
          </v-layout>
          <v-btn>Modify</v-btn>
        </v-toolbar>
        <v-tabs
          v-model="activeTab"
          dark
        >
          <v-tab
            key="grants"
            ripple
          >
            Table Grants
          </v-tab>
          <v-tab-item
            key="grants"
          >
            <v-card flat>
            <policy-definition-grant-grid
              :policy="policy"
              :disabled="disabled"
            ></policy-definition-grant-grid>
            </v-card>
          </v-tab-item>

          <v-tab
            key="rls"
            ripple
            :disabled="!enableRls"
          >
            Row Level Security
          </v-tab>
          <v-tab-item
            key="rls"
          >
            <v-card flat>
            <policy-rls-qualifier-grid
              :policy="policy"
              :disabled="disabled"
            ></policy-rls-qualifier-grid>
            </v-card>
          </v-tab-item>

          <v-tab
            key="policy-template"
            ripple
          >
            {{ table ? 'Policy' : 'Policy Template'}}
          </v-tab>
          <v-tab-item
            key="policy-template"
          >
            <v-card flat>
              <v-container>
                <v-toolbar>
                  <v-layout
                    align-center
                    align-content-center
                    justify-center
                    justify-content-center
                  >
                    <v-tooltip bottom>
                      <template v-slot:activator="{ on }">
                        <v-btn @click="expand" v-on="on"><v-icon>note_add</v-icon></v-btn>
                      </template>
                      <span>Expand</span>
                    </v-tooltip>
                    <v-tooltip bottom>
                      <template v-slot:activator="{ on }">
                        <v-btn v-on="on"><v-icon>file_copy</v-icon></v-btn>
                      </template>
                      <span>Copy</span>
                    </v-tooltip>
                    <v-tooltip bottom>
                      <template v-slot:activator="{ on }">
                        <v-btn v-on="on" :hidden="!table"><v-icon>arrow_forward</v-icon></v-btn>
                      </template>
                      <span>Execute</span>
                    </v-tooltip>
                    <v-spacer></v-spacer>
                    <v-radio-group v-model="policyReadability" row>
                      <v-radio
                        key="terse"
                        label="Terse"
                        value="terse"
                      ></v-radio>
                      <v-radio
                        key="verbose"
                        label="Verbose"
                        value="verbose"
                      ></v-radio>
                    </v-radio-group>
                  </v-layout>
                </v-toolbar>
                <v-textarea
                  :value="computedPolicy"
                  auto-grow
                  hide-details
                  background-color="black"
                  disabled
                >
                </v-textarea>
              </v-container>
            </v-card>
          </v-tab-item>

        </v-tabs>
      </v-container>
    </v-card>
</template>

<script>
  const ALLOWED = 'ALLOWED'
  const DENIED = 'DENIED'
  const IMPLIED = 'IMPLIED'

  import PolicyDefinitionGrantGrid from './PolicyDefinitionGrantGrid.vue'
  import PolicyRlsQualifierGrid from './PolicyRlsQualifierGrid.vue'
  import PolicyComputerMixin from './PolicyComputerMixin'

  export default {
    name: 'PolicyDefinition',
    mixins: [
      PolicyComputerMixin
    ],
    components: {
      PolicyDefinitionGrantGrid,
      PolicyRlsQualifierGrid
    },
    props: {
      policyId: {
        type: Number,
        required: true
      },
      table: {
        type: Object,
        required: false
      }
    },
    data () {
      return {
        enableRls: true,
        policyStructure: [],
        calculatedPolicy: 'NOT CALCULATED',
        toggleCompleted: false,
        activeTab: '',
        policyReadability: 'terse',
        computedPolicy: 'N/A'
      }
    },
    mounted () {
      this.doComputePolicy()
    },
    watch: {
      policyReadability () {
        this.doComputePolicy()
      },
      policy () {
        this.doComputePolicy()
      },
      enableRls () {
        console.log('enableRls', this.enableRls)
        this.$store.commit('savePolicy', {
          policy: {
            ...this.policy,
            enableRls: this.enableRls
          }
        })
      }
    },
    methods: {
      expand () {
        this.computedPolicy = `${this.computedPolicy}=`
      },
      roleGrantSelected(roleGrant, action) {
        return [ALLOWED, IMPLIED].indexOf(roleGrant[action]) > -1
      },
      roleGrantDisabled(roleGrant, action) {
        return roleGrant[action] === IMPLIED
      },
      doComputePolicy () {
        const variables = this.table ? {
          schemaName: this.table.tableSchema,
          tableName: this.table.name
        } : null
        this.computedPolicy = this.computePolicy(this.policy, this.policyReadability, variables)
      },
      toggleEnableRls () {
        if (this.toggleCompleted) {
          this.toggleCompleted = false
          return
        } else {
          console.log('enableRlsCheckbox', this.$refs.enableRlsCheckbox)
          // this.$store.commit('savePolicy', {
          //   policy: {
          //     ...this.policy,
          //     enableRls: this.enableRls
          //   }
          // })
          this.toggleCompleted = true
        }
        // console.log('toggle', value)
      }
    },
    computed: {
      // enableRls () {
      //   return this.policy.enableRls
      // },
      disabled () {
        return this.table !== null && this.table !== undefined
      },
      policy () {
        const policies = this.$store.state.policies
        const pol = this.$store.state.policies.find(p => p.id === this.policyId)
        return pol
      },
      defaultRlsQual () {
        return this.$store.state.defaultRlsQual
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
      },
    },
    mounted () {
      this.enableRls = this.policy.enableRls
    }
  }
</script>