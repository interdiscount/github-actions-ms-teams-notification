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
BRAND_IMAGE_URL='https://storage.googleapis.com/static-shops/github-actions/interdiscount.png'
if [ "$BRAND" == "Dashboard" ]; then
    BRAND_IMAGE_URL='https://storage.googleapis.com/static-shops/github-actions/dashboard.png'
fi

# COLOR
COLOR='default'
if [[ "$STATE" =~ ^(Success|success|Started|started)$ ]]; then
    COLOR='good'
fi

if [[ "$STATE" =~ ^(Failed|failed)$ ]]; then
    COLOR='warning'
fi

echo "Notify MS Teams Channel"

# PERFORM REQUEST
curl --location --request POST $WEBHOOK \
--header 'Content-Type: application/json' \
--data-raw '{
    "type": "message",
    "attachments": [
        {
            "contentType": "application/vnd.microsoft.card.adaptive",
            "content": {
                "type": "AdaptiveCard",
                "body": [
                    {
                        "type": "TextBlock",
                        "spacing": "Small",
                        "size": "Medium",
                        "weight": "Bolder",
                        "text": "'"$STATE"': Deployment to '"$BRAND"' '"$STAGE"'",
                        "style": "heading",
                        "color": "'"$COLOR"'",
                        "wrap": true
                    },
                    {
                        "type": "ColumnSet",
                        "columns": [
                            {
                                "type": "Column",
                                "items": [
                                    {
                                        "type": "Image",
                                        "url": "'"$BRAND_IMAGE_URL"'",
                                        "size": "Small"
                                    }
                                ],
                                "width": "auto"
                            },
                            {
                                "type": "Column",
                                "items": [
                                    {
                                        "type": "TextBlock",
                                        "weight": "Bolder",
                                        "text": "'"$VERSION"'",
                                        "wrap": true
                                    },
                                    {
                                        "type": "TextBlock",
                                        "spacing": "None",
                                        "text": "'"$NOW"'",
                                        "isSubtle": true,
                                        "wrap": true
                                    }
                                ],
                                "width": "stretch"
                            }
                        ]
                    },
                    {
                        "type": "FactSet",
                        "facts": [
                            {
                                "title": "Service",
                                "value": "'"$SERVICE"'",
                            }
                        ]
                    }
                ],
                "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                "version": "1.4"
            }
        }
    ]
}'
