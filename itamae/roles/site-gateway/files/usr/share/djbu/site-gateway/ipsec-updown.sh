#!/bin/bash

exec sudo -n /usr/share/djbu/site-gateway/ipsec-updown-privileged.sh \
  PLUTO_UNIQUEID="${PLUTO_UNIQUEID}" \
  PLUTO_VERB="${PLUTO_VERB}" \
  PLUTO_ME="${PLUTO_ME}" \
  PLUTO_PEER="${PLUTO_PEER}" \
  PLUTO_MARK_IN="${PLUTO_MARK_IN}" \
  PLUTO_MARK_OUT="${PLUTO_MARK_OUT}" \
  PLUTO_CONNECTION="${PLUTO_CONNECTION}" \
  2>&1 | systemd-cat -t "nkmi-ipsec-updown/${PLUTO_CONNECTION}"
