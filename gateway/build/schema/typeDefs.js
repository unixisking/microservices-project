const typeDefs = `#graphql
  type AccessToken {
    token: String!
  }

  type Query {
    validateToken(token: String!): Boolean!
  }
  type Mutation {
    login(username: String!, password: String!): AccessToken!
    register(username: String!, password: String!): String!
  }
`;
export default typeDefs;
