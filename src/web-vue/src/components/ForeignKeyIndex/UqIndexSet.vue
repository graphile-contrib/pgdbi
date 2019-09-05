<template>
  <v-container>
    <v-card
      class="ma-3 pa-3 purple"
      dense
    >            
      <h2>Single-Column Unique Indices</h2>
      <hr>
      <v-data-table
        :headers="headers"
        :items="singleColumnItems"
        class="elevation-1 text-no-wrap"
        hide-default-footer
        show-expand
        calculate-widths
        dense
        :items-per-page="singleColumnItems.length"
      >
        <template v-slot:item.uqTableId="{ item }">
          <router-link :to="{ name: 'table', params: { id: item.uqTableId }}" target="_blank" v-if="item.uqTableId">{{item.uqTableId}}</router-link>
        </template>

        <template v-slot:item.uqIndexEvaluation="{ item }">
          <span :class="item.indexDisplayClass">{{ item.uqIndexEvaluation }}</span>
        </template>

        <template v-slot:item.uqSource="{ item }">
          <div v-for="col in item.idxColumns" :key="col">{{col}}</div>
        </template>

        <template slot="expanded-item" slot-scope="props">
          <td :colspan="headers.length + 1">
            <table-generic-index-detail
              :evaluation="props.item"
            ></table-generic-index-detail>
          </td>
        </template>
      </v-data-table>
    </v-card>

    <v-card
      class="ma-3 pa-3 purple darken-4"
      dense
    >            
      <h2>Multi-Column Unique Indices</h2>
      <hr>
      <v-data-table
        :headers="headers"
        :items="multiColumnItems"
        class="elevation-1 text-no-wrap"
        hide-default-footer
        show-expand
        calculate-widths
        dense
        :items-per-page="multiColumnItems.length"
      >
        <template v-slot:item.uqTableId="{ item }">
          <router-link :to="{ name: 'table', params: { id: item.uqTableId }}" target="_blank" v-if="item.uqTableId">{{item.uqTableId}}</router-link>
        </template>

        <template v-slot:item.uqIndexEvaluation="{ item }">
          <span :class="item.indexDisplayClass">{{ item.uqIndexEvaluation }}</span>
        </template>

        <template v-slot:item.uqSource="{ item }">
          <div v-for="col in item.idxColumns" :key="col">{{col}}</div>
        </template>

        <template slot="expanded-item" slot-scope="props">
          <td :colspan="headers.length + 1">
            <table-generic-index-detail
              :evaluation="props.item"
            ></table-generic-index-detail>
          </td>
        </template>
      </v-data-table>
    </v-card>
  </v-container>
</template>

<script>
  import TableGenericIndexDetail from '@/components/Table/TableGenericIndexDetail'
  
  export default {
    name: 'TableUqIndices',
    components: {
      TableGenericIndexDetail
    },
    props: {
      uqIndexEvaluations: {
        type: Object,
        required: true
      }
    },
    methods: {
      changeSort (column) {
        if (this.pagination.sortBy === column) {
          this.pagination.descending = !this.pagination.descending
        } else {
          this.pagination.sortBy = column
          this.pagination.descending = false
        }
      }
    },
    computed: {
      singleColumnItems () {
        return Object.values(this.uqIndexEvaluations.singleColumn).flat()
      },
      multiColumnItems () {
        return Object.values(this.uqIndexEvaluations.multiColumn).flat()
      }
    },
    data: () => ({
      headers: [
        {
          text: 'Constraint Name',
          value: 'constraintName',
          width: '25%'
        },
        {
          text: 'Table',
          value: 'uqTableId',
          width: '20%'
        },
        {
          text: 'Uq Column',
          value: 'uqSource',
          width: '25%'
        },
        {
          text: 'Index',
          value: 'uqIndexEvaluation',
          width: '30%'
        },
      ]
    })
  }
</script>

<style>

</style>
