#!/usr/bin/env bash
set -o errexit

# Python deps
pip install -r requirements.txt

# Ensure Node/Yarn present (Render’s Node is usually available; if not, add a Node service/runtime)
# Frontend build
cd vue3
# Clean previous outputs to avoid stale manifests
rm -rf node_modules dist
yarn install --frozen-lockfile || yarn install
# Make sure Vite runs a production build with manifest
# If your vite.config.ts doesn’t already set build.manifest = true and outDir = 'dist',
# Vite sets manifest in build mode by default.
yarn build
cd ..

# Django
python manage.py collectstatic --no-input
python manage.py migrate
