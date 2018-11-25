#!/bin/bash

TODAY=$(date "+%Y%m%d")
YESTERDAY=$(date -d "yesterday" "+%Y%m%d")
CURRENT_HOUR=$(date +%k)

function get_current_date_with_delta()
{
  local delta=${1}

  let "hour = CURRENT_HOUR + delta"

  if [[ ${hour} -lt 0 ]] ; then
    let "hour = hour + 24"
    day=${YESTERDAY}
  else
    day=${TODAY}
  fi

  if [[ ${hour} -lt 10 ]] ; then
    hour="0${hour}"
  fi

  echo "${day}T${hour}0000"
}

export TIMEWARRIORDB=/tmp/timewarriordb
mkdir -p ${TIMEWARRIORDB}
rm -f ${TIMEWARRIORDB}/data/*.data
:> ${TIMEWARRIORDB}/timewarrior.cfg

five_hours_before=$(get_current_date_with_delta "-5")
four_hours_before=$(get_current_date_with_delta "-4")
three_hours_before=$(get_current_date_with_delta "-3")
two_hours_before=$(get_current_date_with_delta "-2")
one_hour_before=$(get_current_date_with_delta "-1") 
current_hour=$(get_current_date_with_delta "0")
one_hour_after=$(get_current_date_with_delta "1")
two_hours_after=$(get_current_date_with_delta "2")

src/timew get dom.active.tag.0

src/timew start FOO

src/timew get dom.active.tag.0
src/timew get dom.active.tag.1
