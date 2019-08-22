<template>
  <v-container fluid>
    <v-row>
      <v-col cols="12">
        <v-row
          class="blue darken-4"
        >
          <v-col cols="4">
            <v-card
              class="ma-1 pa-1"
              outlined
              tile
            >
              <h4>Indices</h4>
              <hr>
              <v-card v-for="i in columnInfo.columnIndices" :key="i.id" class="ma-1 pa-1 grey darken-4 text-no-wrap">
                {{i.indexName}}
              </v-card>
            </v-card>
          </v-col>
         
          <v-col cols="4">
            <v-card
              class="ma-1 pa-1"
              dense
            >
              <h4>Foreign Keys</h4>
              <hr>
              <v-card v-for="fk in columnInfo.fkConstraintUsage" :key="fk.id" class="ma-1 pa-1 grey darken-4 text-no-wrap">
                {{fk.constraintName}}
                <hr>
                REF: <router-link :to="{ name: 'table', params: { id: fk.fkTableLinkId }}" target="_blank" v-if="fk.fkTableLinkId">{{fk.fkPath}}</router-link>
                <hr>
                IDX: <span :class="fkIndexClass(fk.fkIndexEvaluation)">{{fk.fkIndexEvaluation}}</span>
              </v-card>
            </v-card>
          </v-col>

          <v-col cols="4">
            <v-card
              class="ma-1 pa-1"
              dense
            >
              <h4>Unique Constraints</h4>
              <hr>
              <v-card v-for="uq in columnInfo.uqConstraintUsage" :key="uq.id" class="ma-1 pa-1 grey darken-4 text-no-wrap">
                {{uq.constraintName}}
                <hr>
                IDX: <span :class="uqIndexClass(uq.uqIndexEvaluation)">{{uq.uqIndexEvaluation}}</span>
              </v-card>
            </v-card>
          </v-col>

        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  const NO_INDEX = 'NO INDEX'
  const MULTIPLE_INDICES = 'MULTIPLE_INDICES'
  export default {
    name: 'ColumnDetail',
    props: {
      columnInfo: {
        type: Object,
        required: true
      }
    },
    methods: {
      fkIndexClass (text) {
        return text === NO_INDEX ? 'red--text' : (text === MULTIPLE_INDICES ? 'yellow--text' : 'green--text')
      },
      uqIndexClass (text) {
        return text === NO_INDEX ? 'red--text' : (text === MULTIPLE_INDICES ? 'yellow--text' : 'green--text')
      }
    },
  }
</script>