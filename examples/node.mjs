// Building Permit Leads - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// New construction over $250k in Chicago and Seattle, last 30 days
const run = await client.actor('Turboextract/building-permit-leads').call({
    "cities": [
        "chicago",
        "seattle"
    ],
    "trades": [
        "new_construction"
    ],
    "minValue": 250000,
    "daysBack": 30
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.city, item.issuedDate, item.value, item.description);
}
