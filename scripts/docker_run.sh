#!/usr/bin/env bash
set -e
echo "=========================================="
echo "🐳 Launching Tomb OS Hardened Docker Container Environment"
echo "=========================================="
docker-compose up -d --build
echo "✅ Tomb OS Container running safely on http://localhost:8080"
