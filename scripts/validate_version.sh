#!/bin/bash
#
# Copyright (c) 2023, Oracle Corporation and/or its affiliates.
#
# Licensed under the Universal Permissive License v 1.0 as shown at
# http://oss.oracle.com/licenses/upl.

KEYCLOAK_VERSION=$1

if ! [[ ${KEYCLOAK_VERSION} =~ [0-9]+\.[0-9]+\.[0-9]+  ]]; then
  echo "${KEYCLOAK_VERSION} is not a valid Keycloak version, exiting."
  exit 1
fi