"""Building Permit Leads - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# Solar and electrical permits with a contractor in Austin and NYC
run = client.actor("Turboextract/building-permit-leads").call(run_input={
    "cities": [
        "austin",
        "nyc"
    ],
    "trades": [
        "solar",
        "electrical"
    ],
    "requireContractor": True
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("city"), item.get("issuedDate"), item.get("value"), item.get("description"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
