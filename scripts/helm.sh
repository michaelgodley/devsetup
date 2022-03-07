#!/bin/bash

. ../config.conf
. ./libs.sh

curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash -s -
