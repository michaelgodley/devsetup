#!/bin/bash

. ../config.conf
. libs.sh

docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher:$RANCHER_VERSION
mkdir ~/.kube
chmod -R go-rx ~/.kube
