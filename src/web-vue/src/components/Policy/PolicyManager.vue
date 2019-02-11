<template>
    <div>
      <family-policy-definition
        v-for="family in families"
        :key="family.name"
        :family="family"
        :policy="defaultPolicySet"
      ></family-policy-definition>
    </div>
</template>

<script>
  import FamilyPolicyDefinition from './Family/FamilyPolicyDefinition.vue'

  export default {
    name: 'PolicyManager',
    components: {
      FamilyPolicyDefinition
    },
    computed: {
      familyPolicySets () {
        return this.$store.state.familyPolicySets
      },
      defaultPolicySet () {
        return this.familyPolicySets.find(fps => fps.name === 'Default') || {
          name: 'Default'          
        }
      },
      families () {
        console.log('heyo', this.$store.state.selectedRoleFamilies)
        return this.$store.state.selectedRoleFamilies
      },

    },
    data () {
      return {

      }
    }
  }
</script>