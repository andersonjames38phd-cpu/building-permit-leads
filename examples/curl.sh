#!/usr/bin/env bash
# Building Permit Leads - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~building-permit-leads"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Solar and electrical permits with a contractor in Austin and NYC (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "cities": [
      "austin",
      "nyc"
    ],
    "trades": [
      "solar",
      "electrical"
    ],
    "requireContractor": true
  }'

# 2. New construction over $250k in Chicago and Seattle, last 30 days (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "cities": [
      "chicago",
      "seattle"
    ],
    "trades": [
      "new_construction"
    ],
    "minValue": 250000,
    "daysBack": 30
  }'

# 3. Every roofing permit this week (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "trades": [
      "roofing"
    ],
    "daysBack": 7,
    "maxResults": 1000
  }'
