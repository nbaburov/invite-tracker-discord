#!/usr/bin/env bash
# Showcase CI: what "builds and runs from a clean checkout" means for this repository.
# Called by the shared workflow in nbaburov/.github; run it locally with `bash ci.sh`.
# Every check runs in a pinned container, so the result does not depend on the machine.
set -euo pipefail
cd "$(dirname "$0")"

docker run --rm -v "$PWD":/w -w /w python:3.12-slim sh -c '
  pip install -q -r requirements.txt &&
  python -m py_compile app.py &&
  python -c "import discord"'
