<template>
  <v-container
    ma-0 
    pa-0
  >
    <h1>Table Security Manager</h1>
    <h2>A tool to ensure that all <a href="https://learn.graphile.org/docs/PostgreSQL_Row_Level_Security_Infosheet.pdf" target="_blank">table grants and rls policies</a> are properly configured to support postgraphile</h2>
    <hr>
    <v-tabs
      v-model="activeTab"
      dark
    >
      <v-tab
        key="policy-manager"
        ripple
      >
        Policy Templates
      </v-tab>
      <v-tab-item
        key="policy-manager"
        lazy
      >
        <v-card>
          <policy-manager></policy-manager>
        </v-card>
      </v-tab-item>

      <v-tab
        key="policyAssignment"
        ripple
      >
        Policy Assignment
      </v-tab>
      <v-tab-item
        key="policyAssignment"
        lazy
      >
        <v-card>
          <v-layout row wrap>
            <v-flex xs12>
              <v-card key="olicyAssignment">
                <policy-assignment></policy-assignment>
              </v-card>
            </v-flex>
          </v-layout>
        </v-card>
      </v-tab-item>

      <v-tab
        key="policies"
        ripple
      >
        Schema Security Scripts
      </v-tab>
      <v-tab-item
        key="policies"
        lazy
      >
        <v-card>
          <schema-security-scripts></schema-security-scripts>
        </v-card>
      </v-tab-item>
      
      <v-tab
        key="cheatsheet"
        lazy
      >
        Cheatsheet
      </v-tab>
      <v-tab-item
        key="cheatsheet"
        lazy
      >
        <v-card>
          <div v-html="cheatsheetData"></div>
        </v-card>
      </v-tab-item>
    </v-tabs>

    </v-tabs>
  </v-container>
</template>

<script>
  import rp from 'request-promise'

  import PolicyAssignment from '@/components/TableSecurity/Assignment/TablePolicyAssignment'
  import SecurityPolicySettings from '@/components/Settings/SecurityPolicySettings'
  import SchemaSecurityScripts from '@/components/TableSecurity/Realization/SchemaSecurityScripts'
  import PolicyManager from '@/components/TableSecurity/TablePolicyManager'

  export default {
    name: 'TableSecurityView',
    components: {
      SecurityPolicySettings,
      SchemaSecurityScripts,
      PolicyManager,
      PolicyAssignment
    },
    props: {
    },
    computed: {
      async cheatsheetData () {
        const data = await rp('https://learn.graphile.org/docs/PostgreSQL_Row_Level_Security_Infosheet.pdf')
        console.log(data)
        return data

        // return rp('https://learn.graphile.org/docs/PostgreSQL_Row_Level_Security_Infosheet.pdf')
        //     .then(function (htmlString) {
        //         return htmlString
        //     })
        //     .catch(function (err) {
        //         console.error(err)
        //     });
      }
    },
    data: () => ({
      activeTab: null
    })
  }
</script>

<style>

</style>
