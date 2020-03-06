#!/bin/bash

set -x

TOP_DIR="$(dirname $(dirname $(readlink -f ${0})))"
sed -i \
  -e 's,.*if(typeof globalNewVersionNotifyUsers.*$,,g' \
  -e 's,.*netVersionCheck.*$,,g' \
  ${TOP_DIR}/build/infcloud/main.js
