const clog = require('fbkt-clog')
const { makeExtendSchemaPlugin, gql } = require("graphile-utils");

const DbSchemaPlugin = makeExtendSchemaPlugin(build => {
  const { pgSql: sql } = build;
  return {
    typeDefs: gql`
    type Function {
      id: String!
      functionName: String!
      functionSchema: String!
      resultDataType: String
      argumentDataTypes: String
      definition: String
    }

    extend type Schema {
      id: String!
      schemaTables: [Table]!
      schemaFunctions: [Function]!
    }

    type Index {
      id: String!
      indexName: String!
      tableSchema: String!
      tableName: String!
      columnName: String!
    }

    extend type Table {
      id: String!
      tableColumns: [Column]!
      indices: [Index]!
      tableConstraints: [ConstraintTableUsage]!
      referentialConstraints: [ReferentialConstraint]!
      checkConstraints: [CheckConstraint]!
      primaryKeyConstraints: [TableConstraint]!
      uniqueConstraints: [TableConstraint]!
      roleTableGrants: [RoleTableGrant]!
      roleColumnGrants: [RoleColumnGrant]!
    }

    extend type ReferentialConstraint {
      referencingColumnUsage: [KeyColumnUsage]!
      referencedColumnUsage: [KeyColumnUsage]!
    }

    extend type CheckConstraint {
      tableConstraints: [TableConstraint]!
    }

    extend type TableConstraint {
      keyColumnUsage: [KeyColumnUsage]!
    }
    
    extend type Query {
      tableById(id: String!): Table
      functionById(id: String!): Function
    }
  `,
  resolvers: {
      Schema: {
        id: require('./resolvers/schema/id')(build),
        schemaTables: require('./resolvers/schema/schemaTables')(build),
        schemaFunctions: require('./resolvers/schema/schemaFunctions')(build),
      },
      Table: {
        id: require('./resolvers/table/id')(build),
        tableColumns: require('./resolvers/table/tableColumns')(build),
        indices: require('./resolvers/table/indices')(build),
        tableConstraints: require('./resolvers/table/tableConstraints')(build),
        referentialConstraints: require('./resolvers/table/referentialConstraints')(build),
        checkConstraints: require('./resolvers/table/checkConstraints')(build),
        primaryKeyConstraints: require('./resolvers/table/primaryKeyConstraints')(build),
        uniqueConstraints: require('./resolvers/table/uniqueConstraints')(build),
        roleTableGrants: require('./resolvers/table/roleTableGrants')(build),
        roleColumnGrants: require('./resolvers/table/roleColumnGrants')(build)
      },
      ReferentialConstraint: {
        referencingColumnUsage: require('./resolvers/referentialConstraint/referencingColumnUsage')(build),
        referencedColumnUsage: require('./resolvers/referentialConstraint/referencedColumnUsage')(build)
      },
      CheckConstraint: {
        tableConstraints: require('./resolvers/checkConstraint/tableConstraint')(build)
      },
      TableConstraint: {
        keyColumnUsage: require('./resolvers/tableConstraint/keyColumnUsage')(build)
      },
      Query: {
        tableById: require('./resolvers/table/tableById')(build),
        functionById: require('./resolvers/function/functionById')(build)
      }
    },
  };
});

module.exports = DbSchemaPlugin
