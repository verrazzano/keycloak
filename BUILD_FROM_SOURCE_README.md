# Build Instructions

The base tag this release is branched from is https://github.com/keycloak/keycloak/tree/20.0.1

---
## Build
Prerequisites: Building Keycloak from source requires the following:
* JDK 11 (or newer)
* Maven 3.5.4 (or newer).
* Git

```
 git clone https://github.com/verrazzano/keycloak
 # git checkout oracle/release/20.0.1 or a branch created from oracle/release/20.0.
 # cd <project directory>/quarkus

 # build the project for the first time to put required modules of Keycloak into local maven cache in package org.keycloak
 mvn --settings ../maven-settings.xml -f ../pom.xml clean install -DskipTestsuite -DskipExamples -DskipTests
 
 # build Keycloak Quarkus distribution
 mvn --settings ../maven-settings.xml -f dist/pom.xml clean install
```

A successful maven build creates the distribution archive keycloak-20.0.1.tar.gz under keycloak/quarkus/dist/target.  

Copy keycloak-<version>.tar.gz and other files required for building the image to verrazzano/keycloak/quarkus/container.
```
 cd verrazzano/keycloak
 cp quarkus/dist/target/keycloak-20.0.1.tar.gz quarkus/container
 cp THIRD_PARTY_LICENSES.txt quarkus/container
 cp SECURITY.md quarkus/container
 cp LICENSE.txt quarkus/container
 cp README.md quarkus/container
```

### Build and Push Image to a Container Registry
 
In order to tag and push the docker image, define the following environment variables:

```
 export DOCKER_REPO=<Docker Repository>
 export DOCKER_NAMESPACE=<Docker Namespace>
 export DOCKER_TAG=<Docker Tag>
 export DOCKER_IMAGE_NAME=keycloak
```

Build and push the image to container registry:
```
 cd verrazzano/keycloak/quarkus/container
 docker image build --build-arg KEYCLOAK_DIST=keycloak-20.0.1.tar.gz -f ./Dockerfile_verrazzano -t ${DOCKER_REPO}/${DOCKER_NAMESPACE}/${DOCKER_IMAGE_NAME}:${DOCKER_TAG} .
 docker image push ${DOCKER_REPO}/${DOCKER_NAMESPACE}/${DOCKER_IMAGE_NAME}:${DOCKER_TAG}
```
