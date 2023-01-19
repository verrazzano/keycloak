# Build Instructions

The base tag this release is branched from is `20.0.1`

---
## Build
Prerequisites: Building Keycloak from source requires the following:
* JDK 11 (or newer)
* Maven 3.5.4 (or newer).

Building Keycloak server from source and creating an image, assumes the source files from the repository https://github.com/verrazzano/keycloak from branch oracle/release/20.0.1 or a branch created from oracle/release/20.0.1, is available under base directory _verrazzano_.

To build only the Keycloak server, run:  
```
 cd verrazzano/keycloak/quarkus
 # build the project for the first time to put required modules of Keycloak into local maven cache in package org.keycloak
 mvn --settings ../maven-settings.xml -f ../pom.xml clean install -DskipTestsuite -DskipExamples -DskipTests
 
 # build Keycloak Quarkus distribution
 mvn --settings ../maven-settings.xml -f dist/pom.xml clean install
```

A successful maven build creates the distribution archive keycloak-20.0.1.tar.gz under keycloak/quarkus/dist/target.  

Copy keycloak-<version>.tar.gz and other files required for building the image to verrazzano/keycloak-containers/server.  
```
 cd verrazzano/keycloak
 cp quarkus/dist/target/keycloak-20.0.1.tar.gz keycloak/quarkus/container
 cp THIRD_PARTY_LICENSES.txt keycloak/quarkus/container
 cp SECURITY.md keycloak/quarkus/container
 cp LICENSE.txt keycloak/quarkus/container
 cp README.md keycloak/quarkus/container
```

### Build and Push Image to a Container Registry
 
In order to tag and push the docker image, define the following environment variables:

```
 export DOCKER_REPO=<Docker Repository>
 export DOCKER_NAMESPACE=<Docker Namespace>
 export DOCKER_TAG=<Docker Tag>
```

Build and push the image to container registry:
```
 cd verrazzano/keycloak/quarkus/container
 docker image build --build-arg KEYCLOAK_DIST=keycloak-20.0.1.tar.gz -f ./Dockerfile_verrazzano -t ${DOCKER_REPO}/${DOCKER_NAMESPACE}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} .
 docker image push ${DOCKER_REPO}/${DOCKER_NAMESPACE}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
```


