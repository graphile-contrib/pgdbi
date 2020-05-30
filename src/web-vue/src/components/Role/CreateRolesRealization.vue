<template>
  <v-container>
    <script-viewer
      :scriptText="computedPolicy"
      @readability-changed="policyReadabilityChanged"
      skipFormat
    ></script-viewer>
  </v-container>
</template>

<script>
  import ScriptViewer from '@/components/_common/ScriptViewer'
  import VueClipboard from 'vue-clipboard2'
  import computeRolesSql from '@/scriptCompute/computeRolesSql.js'

  export default {
    name: 'CreateRolesRealization',
    mixins: [
      VueClipboard
    ],
    components: {
      ScriptViewer
    },
    props: {
    },
    data () {
      return {
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
      enableRls () {
        this.doComputePolicy()
      },
      policyDefinition () {
        this.doComputePolicy()
      }
    },
    methods: {
    policyReadabilityChanged (policyReadability) {
      this.policyReadability = policyReadability
    },
    refresh () {
      this.doComputePolicy()
    },
    expand () {
      this.computedPolicy = `${this.computedPolicy} `
    },
//     computeDbOwnerRoleSql () {
//       const dbOwnerRole = this.$store.state.roleSet.dbOwnerRole
//       return `
// ------------  DB OWNER ROLE ------------
// DO
// $body$
// BEGIN
//   IF NOT EXISTS (
//     SELECT    *
//     FROM   pg_catalog.pg_roles
//     WHERE  rolname = '${dbOwnerRole.roleName}'
//   ) THEN
//     CREATE ROLE ${dbOwnerRole.roleName};
//   END IF;
  
//   ALTER ROLE ${dbOwnerRole.roleName} with LOGIN;
//   ALTER ROLE ${dbOwnerRole.roleName} with CREATEDB;

// END
// $body$;
// --||--
// ---------- END DB OWNER ROLE -----------
//       `

//     },
//     computeDbAuthenticatorRoleSql () {
//       const dbAuthenticatorRole = this.$store.state.roleSet.dbAuthenticatorRole
//       const dbUserRoles = this.$store.state.roleSet.dbUserRoles
//       return `
// ------------  DB AUTHENTICATOR ROLE ------------
// DO
// $body$
// BEGIN
//   IF NOT EXISTS (
//     SELECT    *
//     FROM   pg_catalog.pg_roles
//     WHERE  rolname = '${dbAuthenticatorRole.roleName}'
//   ) THEN
//     CREATE ROLE ${dbAuthenticatorRole.roleName};
//   END IF;
  
//   ALTER ROLE ${dbAuthenticatorRole.roleName} with LOGIN;
//   ALTER ROLE ${dbAuthenticatorRole.roleName} with NOINHERIT;

//   ${dbUserRoles.map(ur => `GRANT ${ur.roleName} TO ${dbAuthenticatorRole.roleName};`).join('\n  ')};

// END
// $body$;
// --||--
// ---------- END DB AUTHENTICATOR ROLE -----------
//       `
//     },
//     computeDbAnonymousRoleSql () {
//       const dbAnonymousRole = this.$store.state.roleSet.dbAnonymousRole
//       return `
// ------------  DB ANONYMOUS ROLE ------------
// DO
// $body$
// BEGIN
//   IF NOT EXISTS (
//     SELECT    *
//     FROM   pg_catalog.pg_roles
//     WHERE  rolname = '${dbAnonymousRole.roleName}'
//   ) THEN
//     CREATE ROLE ${dbAnonymousRole.roleName};
//   END IF;

//   ALTER ROLE ${dbAnonymousRole.roleName} with NOLOGIN;

// END
// $body$;
// --||--
// ---------- END DB ANONYMOUS ROLE -----------
//       `
//     },
//     computeDbUserRolesSql () {
//       const dbUserRoles = this.$store.state.roleSet.dbUserRoles.sort((a,b)=>{
//         return a.applicableRoles.length - b.applicableRoles.length  
//       })
//       return `
// ---------- DB USER ROLES -----------
// ${dbUserRoles.map(ur => {
//   return `
//         ------------ ${ur.roleName}
//           DO
//           $body$
//           BEGIN
//             IF NOT EXISTS (
//               SELECT    *
//               FROM   pg_catalog.pg_roles
//               WHERE  rolname = '${ur.roleName}'
//             ) THEN
//               CREATE ROLE ${ur.roleName};
//             END IF;

//             ALTER ROLE ${ur.roleName} with NOLOGIN;
//             ${ur.applicableRoles.map(ar => {
//               return `
//             GRANT ${ar.roleName} TO ${ur.roleName};`
//             }).join('')}

//           END
//           $body$;
//           --||--
//         -------- END ${ur.roleName}
// `
// }).join('\n')}
// ---------- END USER ROLES ----------
// `
//     },
    // computePolicy () {
    //   return [
    //     this.computeDbOwnerRoleSql(),
    //     this.computeDbAnonymousRoleSql(),
    //     this.computeDbUserRolesSql(),
    //     this.computeDbAuthenticatorRoleSql()
    //   ].join('\n')
    // },
    doComputePolicy () {
      this.computedPolicy = computeRolesSql(this.$store.state)
    },
    onCopy: function (e) {
      alert('Copied!')
    },
    onError: function (e) {
      alert('Failed to copy texts')
    },
    executeSql () {
      alert ('not implemented:  server config value will expose graphile extension to execute generated script')
    }
    },
    computed: {
    }
  }

  // `
  //   DO
  // $body$
  // BEGIN
  //   IF NOT EXISTS (
  //     SELECT    *
  //     FROM   pg_catalog.pg_roles
  //     WHERE  rolname = 'soro'
  //   ) THEN
  //     CREATE ROLE soro;
  //     ALTER ROLE soro with CREATEDB;
  //     ALTER ROLE soro with LOGIN;
  //     ALTER ROLE soro with PASSWORD '84JkExpdMaeEDsc2';
  //   END IF;
  // END
  // $body$;
  // --||--
  // DO
  // $body$
  // BEGIN
  //   IF NOT EXISTS (
  //     SELECT    *
  //     FROM   pg_catalog.pg_roles
  //     WHERE  rolname = 'soro_super_admin'
  //   ) THEN
  //     CREATE ROLE soro_super_admin;
  //     GRANT soro_super_admin to soro;
  //   END IF;
  // END
  // $body$;
  // DO
  // $body$
  // BEGIN
  //   IF NOT EXISTS (
  //     SELECT    *
  //     FROM   pg_catalog.pg_roles
  //     WHERE  rolname = 'soro_admin'
  //   ) THEN
  //     CREATE ROLE soro_admin;
  //     GRANT soro_admin TO soro_super_admin;
  //     GRANT soro_admin to soro;
  //   END IF;
  // END
  // $body$;
  // --||--
  // DO
  // $body$
  // BEGIN
  //   IF NOT EXISTS (
  //     SELECT    *
  //     FROM   pg_catalog.pg_roles
  //     WHERE  rolname = 'soro_user'
  //   ) THEN
  //     CREATE ROLE soro_user;
  //     GRANT soro_user TO soro_super_admin;
  //     GRANT soro_user TO soro_admin;
  //     GRANT soro_user to soro;
  //   END IF;
  // END
  // $body$;
  // DO
  // $body$
  // BEGIN
  //   IF NOT EXISTS (
  //     SELECT    *
  //     FROM   pg_catalog.pg_roles
  //     WHERE  rolname = 'soro_anonymous'
  //   ) THEN
  //     CREATE ROLE soro_anonymous;
  //     GRANT soro_anonymous TO soro_super_admin;
  //     GRANT soro_anonymous TO soro_admin;
  //     GRANT soro_anonymous TO soro_user;
  //     GRANT soro_anonymous to soro;
  //   END IF;
  // END
  // $body$;
  // --||--
  // DO
  // $body$
  // BEGIN
  //   IF NOT EXISTS (
  //     SELECT    *
  //     FROM   pg_catalog.pg_roles
  //     WHERE  rolname = 'soro_authenticator'
  //   ) THEN
  //     CREATE ROLE soro_authenticator with NOINHERIT;
  //     ALTER ROLE soro_authenticator with LOGIN;
  //     ALTER ROLE soro_authenticator with PASSWORD '1234';
  //     GRANT soro_super_admin TO soro_authenticator;
  //     GRANT soro_admin TO soro_authenticator;
  //     GRANT soro_user TO soro_authenticator;
  //     GRANT soro_anonymous TO soro_authenticator;
  //   END IF;
  // END
  // $body$;
  // `
</script>