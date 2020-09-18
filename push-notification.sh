#!/bin/bash

# ALL PARAMS
SERVICE=$1
STATE=$2
STAGE=$3
BRAND=$4
VERSION=$5
WEBHOOK=$6

NOW=$(date +'%d.%m.%Y %H:%M:%S')

# BRAND IMAGE
BRAND_IMAGE_URL='https://www.microspot.ch/images/logos/Microspot_logo.png'
if [ "$BRAND" == "Interdiscount" ] || [ "$BRAND" == "interdiscount" ]; then
    BRAND_IMAGE_URL='https://media.glassdoor.com/sqll/158689/interdiscount-squarelogo-1472471988427.png'
fi

# COLOR
COLOR='49C6e5'
if [ "$STATE" == "Success" ] || [ "$STATE" == "success" ]; then
    COLOR='00ae6d'
fi

if [ "$STATE" == "Failed" ] || [ "$STATE" == "failed" ]; then
    COLOR='e20713'
fi

echo "Notify MS Teams Channel"

# PERFORM REQUEST
curl --location --request POST $WEBHOOK \
--header 'Content-Type: application/json' \
--data-raw '{
    "@type": "MessageCard",
    "@context": "https://schema.org/extensions",
    "summary": "'"$STATE"': Deployment to '"$BRAND"' '"$STAGE"'",
    "themeColor": "'"$COLOR"'",
    "title": "'"$STATE"': Deployment to '"$BRAND"' '"$STAGE"'",
    "sections": [{
        "activityTitle": "'"$VERSION"'",
        "activitySubtitle": "'"$NOW"'",
        "activityImage": "'"$BRAND_IMAGE_URL"'",
        "facts": [{
            "name": "Service",
            "value": "'"$SERVICE"'"
        }]
    }]
}
'