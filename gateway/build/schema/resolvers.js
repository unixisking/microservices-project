import { GraphQLError } from 'graphql';
import keycloak from '../keycloak/keycloak.js';
const resolvers = {
    Query: {
        validateToken: () => { },
    },
    Mutation: {
        login: async (_, args) => {
            const { username, password } = args;
            try {
                const grant = await keycloak.grantManager.obtainDirectly(username, password);
                return grant.access_token;
            }
            catch (error) {
                console.log('error', error);
                throw new GraphQLError('Invalid credentials!', {
                    extensions: {
                        code: 'INTERNAL_SERVER_ERROR',
                    },
                });
            }
        },
        register: async (obj, args, context, info) => {
            const { username, password } = args;
        },
    },
};
export default resolvers;
