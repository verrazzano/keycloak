# Build Instructions

The base tag this release is branched from is `15.0.2`

---
## Build
Prerequisites: Building Keycloak from source requires the following:
* JDK 8 (or newer)
* Maven 3.5.4 (or newer).

Building Keycloak server from source and creating an image, assumes the source files from the repositories https://github.com/keycloak/keycloak
and https://github.com/keycloak/keycloak-containers for tag 15.0.2, are available under base directory _verrazzano_.

To build only the Keycloak server, run:  
`cd verrazzano/keycloak; mvn -Pdistribution -pl distribution/server-dist -am -Dmaven.test.skip clean install`

A successful maven build creates the distribution archive keycloak-<version>.tar.gz under distribution/server-dist/target.  
Copy keycloak-<version>.tar.gz and other files required for building the image to verrazzano/keycloak-containers/server.  

The distribution archive and other required tools available under verrazzano/keycloak-containers can be used to build the docker image
from verrazzano/keycloak-containers/server.  
`
cd verrazzano/keycloak-containers/server; docker image build -f ./Dockerfile_verrazzano -t <docker-image-repo>/keycloak:15.0.2-1 .
`

## Push image to a Container Registry
Push the tagged docker image to the Container Registry using the command:  
`docker image push <docker-image-repo>/keycloak:15.0.2-1`

