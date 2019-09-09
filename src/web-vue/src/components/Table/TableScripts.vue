<template>
  <v-container>
    <v-tabs
      v-model="activeTab"
      dark
    >
      <v-tab
        key="tableDefinition"
        ripple
      >
        Definition
      </v-tab>
      <v-tab-item
        key="tableDefinition"
      >
        <v-card flat>
          <script-viewer
            :scriptText="tableDefinition"
            :showReadability="false"
          ></script-viewer>
        </v-card>
      </v-tab-item>

      <v-tab
        key="tableIndices"
        ripple
      >
        Indices
      </v-tab>
      <v-tab-item
        key="tableIndices"
      >
        <v-card flat>
          <script-viewer
            :scriptText="tableIndicesRealization"
            :showReadability="false"
          ></script-viewer>
        </v-card>
      </v-tab-item>

      <v-tab
        key="tableSecurityPolicy"
        ripple
      >
        Security Policy Script
      </v-tab>
      <v-tab-item
        key="tableSecurityPolicy"
      >
        <v-card flat>
          <table-policy-realization
            :policyDefinition="policyDefinition"
            :table="tableInfo"
          ></table-policy-realization>
        </v-card>
      </v-tab-item>

    </v-tabs>
  </v-container>
</template>

<script>
  // import tableById from '../../gql/query/tableById.graphql';
  // import TableDetail from './TableDetail.vue'
  import ScriptViewer from '@/components/_common/ScriptViewer'
  import TablePolicyRealization from '@/components/TableSecurity/Realization/TablePolicyRealization'

  export default {
    name: 'TableScripts',
    components: {
      ScriptViewer,
      TablePolicyRealization
    },
    props: {
      tableInfo: {
        type: Object,
        required: true
      }
    },
    computed: {
      tableDefinition () {
        return `TABLE DEFINITION NOT IMPLMENTED YET`
      },
      tableIndicesRealization () {
        const genericIndexEvaluations = Object.values(this.$store.state.genericIndexEvaluations).filter(e => e.tableKey === `${this.tableInfo.tableSchema}.${this.tableInfo.tableName}`)
        const genericDrops = genericIndexEvaluations.reduce(
          (all, e) => {
            return e.desiredRealization.drop !== '' ? [...all, this.formatScript(e.desiredRealization.drop)] : all
          }, []
        )
        const genericCreates = genericIndexEvaluations.reduce(
          (all, e) => {
            return e.desiredRealization.create !== '' ? [...all, this.formatScript(e.desiredRealization.create)] : all
          }, []
        )

        const dropText = genericDrops.length > 0 ? `-- INDICES TO DROP\n\n${genericDrops.join('')}` : ''
        const createText = genericCreates.length > 0 ? `-- INDICES TO CREATE\n\n${genericCreates.join('')}` : ''
        const dr = dropText.concat('\n\n').concat(createText)

        return dr
      },
      policyDefinition () {
        const policyDefinitionId = this.$store.state.tablePolicyAssignments[`${this.tableInfo.tableSchema}.${this.tableInfo.tableName}`].policyDefinitionId
        return this.$store.state.policies.find(p => p.id === policyDefinitionId)
      }
    },
    methods: {
      formatScript (scriptText) {
        return (scriptText || '')
          .toLowerCase()
          .split(' exists').join(' exists\n  ')
          .split(' on').join('\non')
          .split(' using').join('\nusing')
          .split(' (').join(' (\n  ')
          .split(',').join('\n  ,')
          .split(');').join('\n);')
      },
    },
    data: () => ({
      activeTab: null,
      // tableInfo: {},
    }),
  }
</script>

<style>

</style>
