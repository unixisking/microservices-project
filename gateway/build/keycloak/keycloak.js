import Keycloak from 'keycloak-connect';
import keycloakConfig from './config.js';
const keycloak = new Keycloak({}, keycloakConfig);
export default keycloak;
