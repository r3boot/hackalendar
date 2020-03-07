#!/bin/sh

USERNAME='test'
PASSWORD='test'
BASE_URL='http://localhost:8080'
PRINCIPAL_REL="/radicale/${USERNAME}/"
PRINCIPAL="${BASE_URL}${PRINCIPAL_REL}"

WANTED_CALENDAR='Events'

LOGIN="--user ${USERNAME}:${PASSWORD}"
FETCH_LISTING="$(cat <<EOF
<d:propfind xmlns:d="DAV:" xmlns:cs="http://calendarserver.org/ns/">
  <d:prop>
  </d:prop>
</d:propfind>
EOF
)"

FETCH_DISPLAYNAME="$(cat <<EOF
<d:propfind xmlns:d="DAV:" xmlns:cs="http://calendarserver.org/ns/">
  <d:prop>
     <d:displayname />
  </d:prop>
</d:propfind>
EOF
)"

#- Name: Inter-Hackerspace Bestuursoverleg
#  Location: Bitlair
#  StartDate: 2020-05-16
#  EndDate: 2020-05-16
#  Comment: Voor hackerspace bestuursleden
#  URL:

curl -s -X PROPFIND ${LOGIN} -H "Depth: 1" \
  --data "${FETCH_LISTING}" "${PRINCIPAL}" \
  | xmllint --pretty 1 - \
  | egrep 'href|/displayname' \
  | sed -e 's,.*<href>,,g' -e 's,</href>.*$,,g' \
  | grep -v "${PRINCIPAL_REL}$" \
  | while read CALENDAR_PATH; do
  IS_WANTED_CALENDAR=0
  curl -s -X PROPFIND ${LOGIN} -H "Depth: 1" \
    --data "${FETCH_DISPLAYNAME}" \
    "${BASE_URL}${CALENDAR_PATH}" \
    | xmllint --pretty 1 - \
    | egrep '/displayname|.ics<' \
    | while read DATA; do
    if [[ ${IS_WANTED_CALENDAR} -eq 1 ]]; then
      echo "${DATA}" | grep -q href
      if [[ ${?} -eq 0 ]]; then
        ICAL_URL="${BASE_URL}$(echo "${DATA}" | sed -e 's,<[a-z/]*>,,g')"
        curl -s -X GET ${LOGIN} -o- ${ICAL_URL} \
          | ./scripts/vevent2yaml.py
      fi
    else
      echo "${DATA}" | grep -q displayname
      if [[ ${?} -eq 0 ]]; then
        NAME="$(echo "${DATA}" | sed -e 's,<[a-z/]*>,,g')"
        echo "${NAME}" | grep -q "${WANTED_CALENDAR}"
        if [[ ${?} -eq 0 ]]; then
          IS_WANTED_CALENDAR=1
        fi
      fi
    fi
  done
done
