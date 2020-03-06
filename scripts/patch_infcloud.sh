#!/bin/bash

set -x

TOP_DIR="$(dirname $(dirname $(readlink -f ${0})))"
sed -i \
  -e 's,.*if(typeof globalNewVersionNotifyUsers.*$,,g' \
  -e 's,.*netVersionCheck.*$,,g' \
  -e 's,^\(.*#cacheDialogText\),//\1,g' \
  -e 's,^\(.*#cacheDialogButton\),//\1,g' \
  ${TOP_DIR}/build/infcloud/main.js

sed -i \
  -e "s/\$('#cacheDialog').css('display','block');/\$('#cacheDialog').css('display','none');/g" \
  ${TOP_DIR}/build/infcloud/cache_handler.js
