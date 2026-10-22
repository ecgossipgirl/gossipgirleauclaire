#!/bin/sh
# Deploys the site to Cloudflare. Run from the project folder: sh deploy.sh
npx wrangler pages deploy public --project-name eau-claire-gossip --branch main
