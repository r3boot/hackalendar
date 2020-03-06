#!/bin/bash

FOUND_ERRORS=0

function check_for_binary {
  TARGET="${1}"

  echo -n "Checking for ${TARGET}: "
  FOUND="$(which ${TARGET} 2>/dev/null)"
  if [[ -z "${FOUND}" ]]; then
    echo 'not found'
    return 1
  else
    echo "${FOUND}"
    return 0
  fi
}

check_for_binary docker
if [[ ${?} -eq 1 ]]; then
  FOUND_ERRORS=1
fi

check_for_binary docker-compose
if [[ ${?} -eq 1 ]]; then
  FOUND_ERRORS=1
fi

check_for_binary htpasswd
if [[ ${?} -eq 1 ]]; then
  FOUND_ERRORS=1
fi

exit ${FOUND_ERRORS}
