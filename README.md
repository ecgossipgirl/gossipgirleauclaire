# Eau Claire Gossip: setup

What you have:

- `public/index.html` is the public site (gossip, breaking, pics, parties, comments, reactions).
- `public/admin.html` is the owner page. Open `yoursite/admin.html`. Only someone with your password can see submissions or moderate.
- `functions/api/[[path]].js` is the backend. `schema.sql` is the database layout.

Comments and party submissions are held until you approve them in the owner page.

## Setup (about 15 minutes, one time)

You need a free Cloudflare account and Node.js (nodejs.org, the LTS version).

Open a terminal in this folder, then run these one at a time.

1. Install and log in:

       npm install -g wrangler
       wrangler login

2. Create the database. It prints a `database_id`. Paste it into `wrangler.toml` in place of `13ec7f13-45c1-4616-a04b-d9e1c9af844a`:

       wrangler d1 create eau-claire-gossip

3. Create the tables:

       wrangler d1 execute eau-claire-gossip --remote --file=schema.sql

4. Create the Pages project and deploy once:

       wrangler pages deploy public --project-name eau-claire-gossip

   (If it asks for a production branch, type `main`.)

5. Set your owner password and a long random session secret. Each command asks you to type the value:

       wrangler pages secret put ADMIN_PASSWORD --project-name eau-claire-gossip
       wrangler pages secret put SESSION_SECRET --project-name eau-claire-gossip

   Use a long password. For SESSION_SECRET, mash out 40 or more random characters. You never need to remember it.

6. Deploy again so the secrets take effect:

       wrangler pages deploy public --project-name eau-claire-gossip

Your site is now live at `https://eau-claire-gossip.pages.dev` (the exact address is printed). Log in at `/admin.html`.

To update the site later, change files and run the deploy command from step 6 again.

## Custom domain

In the Cloudflare dashboard open Workers & Pages, then your project, then Custom domains.

## Strongly recommended

Add a rate-limit rule so nobody can flood your comments or submissions, or guess your password:
Cloudflare dashboard, then Security, then WAF, then Rate limiting rules. Match the path starting with `/api/`, and limit to something like 20 requests per minute per IP. Cloudflare's menus change, so search their docs for "rate limiting rules" if anything looks different.

## Adding links

The links tab is a plain list in `public/index.html`. There is a commented example to copy.
