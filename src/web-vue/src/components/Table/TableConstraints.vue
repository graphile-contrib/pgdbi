<template>
  <v-container>
      <v-tabs
      v-model="activeTab"
      dark
    >
      <v-tab
        key="refcons"
        ripple
      >
        Referential Constraints
      </v-tab>
      <v-tab-item
        key="refcons"
      >
        <v-card flat>
          <table-referential-constraints
            :referentialConstraints="referentialConstraints"
          ></table-referential-constraints>
        </v-card>
      </v-tab-item>

      <v-tab
        key="chk"
        ripple
      >
        Check Constraints
      </v-tab>
      <v-tab-item
        key="chk"
      >
        <v-card flat>
          <table-check-constraints
            :checkConstraints="checkConstraints"
          ></table-check-constraints>
        </v-card>
      </v-tab-item>

      <v-tab
        key="uq"
        ripple
      >
        Unique Constraints
      </v-tab>
      <v-tab-item
        key="uq"
      >
        <v-card flat>
          <table-unique-constraints
            :uniqueConstraints="uniqueConstraints"
          ></table-unique-constraints>
        </v-card>
      </v-tab-item>
    </v-tabs>
</v-container>
</template>

<script>
  import TableReferentialConstraints from './Constraints/TableReferentialConstraints.vue'
  import TableCheckConstraints from './Constraints/TableCheckConstraints.vue'
  import TableUniqueConstraints from './Constraints/TableUniqueConstraints.vue'

  export default {
    name: 'TableConstraints',
    components: {
      TableReferentialConstraints,
      TableCheckConstraints,
      TableUniqueConstraints
    },
    props: {
      tableInfo: {
        type: Object,
        required: true
      }
    },
    computed: {
      referentialConstraints () {
        return this.tableInfo.referentialConstraints || []
      },
      checkConstraints () {
        return this.tableInfo.checkConstraints || []
      },
      uniqueConstraints () {
        return this.tableInfo.uniqueConstraints || []
      },
    },
    methods: {
    },
    data: () => ({
      activeTab: null,
    })
  }
</script>

<style>

</style>
