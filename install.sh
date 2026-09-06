#!/usr/bin/env bash
# ==============================================================================
# Hermes WebUI Persian & RTL Support - One-Click Installer
# Compatible with macOS, Linux, and WSL
# ==============================================================================

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}====================================================${NC}"
echo -e "${BLUE}    Hermes WebUI Persian & RTL Installer 🇮🇷         ${NC}"
echo -e "${BLUE}====================================================${NC}"

# 1. Determine State Directory
STATE_DIR="${HERMES_WEBUI_STATE_DIR:-$HOME/.hermes/webui}"
EXT_DIR="$STATE_DIR/extensions"
TARGET_DIR="$EXT_DIR/vazir-persian-rtl"
MANIFEST_FILE="$STATE_DIR/extension-install-manifest.json"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_EXT_DIR="$SCRIPT_DIR/vazir-persian-rtl"

# If running directly via curl/remote execution where local repo isn't present
if [ ! -d "$SOURCE_EXT_DIR" ]; then
    echo -e "${YELLOW}Downloading latest Persian RTL assets from GitHub...${NC}"
    TMP_DIR=$(mktemp -d)
    trap 'rm -rf "$TMP_DIR"' EXIT
    git clone --depth 1 https://github.com/m4tinbeigi-official/hermes-webui-persian.git "$TMP_DIR/repo"
    SOURCE_EXT_DIR="$TMP_DIR/repo/vazir-persian-rtl"
fi

if [ ! -d "$SOURCE_EXT_DIR" ]; then
    echo -e "${RED}Error: Could not locate extension source files.${NC}"
    exit 1
fi

echo -e "${BLUE}Target directory:${NC} $TARGET_DIR"

# 2. Copy extension files
mkdir -p "$TARGET_DIR"
cp -R "$SOURCE_EXT_DIR/"* "$TARGET_DIR/"

# 3. Update or create extension-install-manifest.json
mkdir -p "$STATE_DIR"

python3 - <<EOF
import json
import os
from pathlib import Path
from datetime import datetime

manifest_path = Path("$MANIFEST_FILE")
data = {"version": 1, "installed": {}}

if manifest_path.exists():
    try:
        with open(manifest_path, "r", encoding="utf-8") as f:
            data = json.load(f)
            if not isinstance(data, dict):
                data = {"version": 1, "installed": {}}
            if "installed" not in data or not isinstance(data["installed"], dict):
                data["installed"] = {}
    except Exception:
        data = {"version": 1, "installed": {}}

data["installed"]["vazir-persian-rtl"] = {
    "version": "1.0.0",
    "files": [
        "manifest.json",
        "vazir-rtl.css",
        "vazir-rtl.js",
        "fonts/Vazirmatn-Regular.woff2",
        "fonts/Vazirmatn-Medium.woff2",
        "fonts/Vazirmatn-SemiBold.woff2",
        "fonts/Vazirmatn-Bold.woff2"
    ],
    "installed_at": datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ")
}

with open(manifest_path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

print("Manifest updated successfully.")
EOF

echo -e "\n${GREEN}✓ Persian & Vazirmatn RTL support installed successfully!${NC}"
echo -e "${GREEN}✓ All updates are persistent and will survive Hermes WebUI version updates.${NC}"
echo -e "${BLUE}Please refresh your Hermes WebUI browser page to enjoy the Persian typography.${NC}\n"
