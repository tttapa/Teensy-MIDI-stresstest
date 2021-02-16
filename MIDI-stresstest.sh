#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

oport=${1:-hw:1,0,0}
iport=${2:-${oport}}

chg="${3:-MIDI-long-challenge.syx}"
rsp="/tmp/response.syx"

amidi -p "${iport}" -d -t 1 > /dev/null
amidi -p "${iport}" -r "$rsp" -t 1 &
/usr/bin/time -f "Duration: %E" amidi -p "${oport}" -s "$chg"
wait
wc -c "${chg}"
wc -c "${rsp}"
sha256sum -b "${chg}"
sha256sum -b "${rsp}"
cmp "${chg}" "${rsp}"