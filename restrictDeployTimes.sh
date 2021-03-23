#!/bin/bash
d=$(date +%u)
h=$(date +%-H)

echo "Is expedite: $1"
echo "Day: $d"
echo "Hour: $h"
bypassExpedite="false"

if ((d <= 4)) ; then
    echo "Mon/Tues/Wed/Thurs"
    if ((h >= 8 && h < 16)) ; then
        echo "Work day"
        bypassExpedite="true"
    else
        echo "Out of office hours"
    fi
elif ((d == 5)) ; then
    echo "Fri"
    if ((h >= 8 && h < 14)) ; then
        echo "Work day"
        bypassExpedite="true"
    else
        echo "Out of office hours"
    fi
else
    echo "Sat/Sun"
    echo "Out of office hours"
fi

echo "Bypass expedite requirement: $bypassExpedite"

if [[ "$1" = "true" || "$bypassExpedite" = "true" ]]; then
    echo 'Deployment can proceed.'
else
    echo 'Deployment cancelled.'
    echo "##teamcity[buildStop comment='Prod deploy expedite out of hours not confirmed.' readdToQueue='false']"
fi
