#!/bin/bash
set -euo pipefail

PORTABLE_DIR="portable"
ZIP_FILE="ii-agent-portable.zip"

# Clean previous build
rm -rf "$PORTABLE_DIR" "$ZIP_FILE"

# Create virtual environment and install package
python3 -m venv "$PORTABLE_DIR/venv"
"$PORTABLE_DIR/venv/bin/pip" install --upgrade pip
"$PORTABLE_DIR/venv/bin/pip" install .

# Copy application entrypoints
cp cli.py ws_server.py run_gaia.py utils.py "$PORTABLE_DIR/"
cp -r src "$PORTABLE_DIR/"

# Provide workspace directory
mkdir -p "$PORTABLE_DIR/workspace"

# Package
(cd "$PORTABLE_DIR" && zip -r "../$ZIP_FILE" .)

echo "Created $ZIP_FILE"
