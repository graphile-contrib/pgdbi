<template>
  <v-container>
    <v-card
      class="ma-3 pa-3 blue-grey"
      dense
    >            
      <h2>Single-Column Foreign Keys</h2>
      <hr>
      <v-data-table
        :headers="singleColumnHeaders"
        :items="singleColumnItems"
        class="elevation-1 text-no-wrap"
        hide-default-footer
        show-expand
        calculate-widths
        dense
        :items-per-page="singleColumnItems.length"
      >
        <template v-slot:item.fkIndexEvaluation="{ item }">
          <span :class="item.indexDisplayClass">{{ item.fkIndexEvaluation }}</span>
        </template>

        <template v-slot:item.fkTable="{ item }">
          <router-link :to="{ name: 'table', params: { id: item.fkTableLinkId }}" target="_blank" v-if="item.fkTableLinkId">{{item.fkTable}}</router-link>
        </template>

        <template v-slot:item.fkSource="{ item }">
          <div v-for="col in item.fkSource" :key="col">{{col}}</div>
        </template>

        <template v-slot:item.fkTarget="{ item }">
          <div v-for="col in item.fkTarget" :key="col">{{col}}</div>
        </template>

        <template slot="expanded-item" slot-scope="props">
          <td :colspan="singleColumnHeaders.length + 1">
            <table-generic-index-detail
              :evaluation="props.item"
            ></table-generic-index-detail>
          </td>
        </template>
      </v-data-table>
    </v-card>

    <v-card
      class="ma-3 pa-3 blue-grey darken-4"
      dense
    >            
      <h2>Multi-Column Foreign Keys</h2>
      <hr>
      <v-data-table
        :headers="multiColumnHeaders"
        :items="multiColumnItems"
        class="elevation-1 text-no-wrap"
        hide-default-footer
        show-expand
        calculate-widths
        dense
        :items-per-page="multiColumnItems.length"
      >
        <template v-slot:item.fkIndexEvaluation="{ item }">
          <span :class="item.indexDisplayClass">{{ item.fkIndexEvaluation }}</span>
        </template>

        <template v-slot:item.fkTable="{ item }">
          <router-link :to="{ name: 'table', params: { id: item.fkTableLinkId }}" target="_blank" v-if="item.fkTableLinkId">{{item.fkTable}}</router-link>
        </template>

        <template v-slot:item.fkSource="{ item }">
          <div v-for="col in item.fkSource" :key="col">{{col}}</div>
        </template>

        <template v-slot:item.fkTarget="{ item }">
          <div v-for="col in item.fkTarget" :key="col">{{col}}</div>
        </template>

        <template slot="expanded-item" slot-scope="props">
          <td :colspan="multiColumnHeaders.length + 1">
            <generic-index-detail
              :evaluation="props.item"
            ></generic-index-detail>
          </td>
        </template>
      </v-data-table>
    </v-card>
  </v-container>
</template>

<script>
  import GenericIndexDetail from './GenericIndexDetail'
  
  export default {
    name: 'FkIndexConstraints',
    components: {
      GenericIndexDetail
    },
    props: {
      fkIndexEvaluations: {
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
        return Object.values(this.fkIndexEvaluations.singleColumn).flat()
      },
      multiColumnItems () {
        return Object.values(this.fkIndexEvaluations.multiColumn).filter(a => a.length > 0).flat()
      }
    },
    data: () => ({
      singleColumnHeaders: [
        {
          text: 'Constraint Name',
          value: 'constraintName'
        },
        {
          text: 'Index',
          value: 'fkIndexEvaluation'
        },
        {
          text: 'FK Table',
          value: 'fkTable'
        },
        {
          text: 'FK Source',
          value: 'fkSource'
        },
        {
          text: 'FK Target',
          value: 'fkTarget'
        }
      ],
      multiColumnHeaders: [
        {
          text: 'Constraint Name',
          value: 'constraintName'
        },
        {
          text: 'Index',
          value: 'fkIndexEvaluation'
        },
        {
          text: 'FK Table',
          value: 'fkTable'
        },
        {
          text: 'FK Source',
          value: 'fkSource'
        },
        {
          text: 'FK Target',
          value: 'fkTarget'
        }
      ],      // pagination: {
      //   sortBy: 'constraintName',
      //   rowsPerPage: -1
      // },
    })
  }
</script>

<style>

</style>
