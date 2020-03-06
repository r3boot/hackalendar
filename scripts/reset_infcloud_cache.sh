#!/bin/bash

set -x

TOP_DIR="$(dirname $(dirname $(readlink -f ${0})))"
NOW="$(date '+%Y%m%d%H%M%S')"
sed -i -e "s,^#V .*$,#V ${NOW},g" ${TOP_DIR}/data/infcloud-rw/cache.manifest
sed -i -e "s,^#V .*$,#V ${NOW},g" ${TOP_DIR}/data/infcloud-ro/cache.manifest
