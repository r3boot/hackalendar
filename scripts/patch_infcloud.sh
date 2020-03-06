#!/bin/bash

set -x

TOP_DIR="$(dirname $(dirname $(readlink -f ${0})))"
cat ${TOP_DIR}/build/infcloud/main.js | sed \
  -e 's,.*if(typeof globalNewVersionNotifyUsers.*$,,g' \
  -e 's,.*netVersionCheck.*$,,g' \
  > ${TOP_DIR}/build/infcloud/main.js.new \
  && mv -v ${TOP_DIR}/build/infcloud/main.js.new ${TOP_DIR}/build/infcloud/main.js
