#!/usr/bin/env bash

# Exit on error
set -o errexit

# Install Python dependencies
pip install -r requirements.txt

# --- Frontend Build ---
# Navigate to the frontend directory
cd vue3
# Install JS dependencies
yarn install
# Build the frontend assets for production
yarn build
# Navigate back to the project root
cd ..

# --- Django ---
# Collect static files (including the ones built by Vite)
python manage.py collectstatic --no-input
# Apply database migrations
python manage.py migrate
