<template>
  <v-card color="black">
    <v-container background-color="black">
      <v-card 
        v-for="status in referentialConstraintStatuses" 
        :key="status"
      >
        <v-toolbar>
          <v-layout row>
            <v-flex xs12>
              <v-layout row>
                <v-flex xs2>
                  <v-chip>{{status}}</v-chip>
                  <v-icon :color="sortedReferentialConstraints[status].columnIndexStatusColor">fiber_manual_record</v-icon>
                </v-flex>
                <v-flex xs2
                  v-for="action in sortedReferentialConstraints[status].actions"
                  :key="action"
                >
                  <v-checkbox 
                    :input-value="false"
                    :label="`${action} all`"
                    @change="actionChanged(action, status)"
                  ></v-checkbox>
                </v-flex>
              </v-layout>
            </v-flex>
          </v-layout>
        </v-toolbar>
        <fk-index-evaluator-segment
          :key="status"
          :actions="sortedReferentialConstraints[status].actions"
          :referentialConstraints="sortedReferentialConstraints[status].referentialConstraints"
        ></fk-index-evaluator-segment>
      </v-card>
    </v-container>
  </v-card>
</template>

<script>
  import FkIndexEvaluatorSegment from '@/components/ForeignKeyIndex/FkIndexEvaluatorSegment.vue'

  export default {
    name: 'FkIndexEvaluator',
    props: {
      table: {
        type: Object,
        required: true
      }
    },
    components: {
      FkIndexEvaluatorSegment
    },
    methods: {
      actionChanged (action, status) {
        console.log('actionChanged', action, status)
      }
    },
    watch: {
    },
    computed: {
      referentialConstraints () {
        return this.table.referentialConstraints
      },
      sortedReferentialConstraints () {
        return this.table.sortedReferentialConstraints
      },
      referentialConstraintStatuses () {
        return Object.keys(this.sortedReferentialConstraints)
          .filter(status => {
            return this.sortedReferentialConstraints[status].referentialConstraintCount > 0
          })
          .sort((a,b)=>{return a<b?-1:1})
      }
    },
    data: () => ({
    })
  }
</script>