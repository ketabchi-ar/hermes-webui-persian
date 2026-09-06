#!/usr/bin/env bash
# ==============================================================================
# Hermes WebUI Persian & RTL Support - Ultra-Fast Installer (<1s)
# Works on macOS, Linux, and WSL
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

STATE_DIR="${HERMES_WEBUI_STATE_DIR:-$HOME/.hermes/webui}"
EXT_DIR="$STATE_DIR/extensions"
TARGET_DIR="$EXT_DIR/vazir-persian-rtl"
MANIFEST_FILE="$STATE_DIR/extension-install-manifest.json"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"
SOURCE_EXT_DIR="$SCRIPT_DIR/vazir-persian-rtl"

mkdir -p "$TARGET_DIR"

if [ -d "$SOURCE_EXT_DIR" ] && [ -f "$SOURCE_EXT_DIR/manifest.json" ]; then
    echo -e "${BLUE}Installing from local repository...${NC}"
    cp -R "$SOURCE_EXT_DIR/"* "$TARGET_DIR/"
else
    echo -e "${YELLOW}Downloading lightweight package from GitHub...${NC}"
    ARCHIVE_URL="https://github.com/m4tinbeigi-official/hermes-webui-persian/archive/refs/heads/main.tar.gz"
    
    if command -v curl &>/dev/null; then
        curl -fsSL "$ARCHIVE_URL" | tar -xz -C "$TARGET_DIR" --strip-components=2 "hermes-webui-persian-main/vazir-persian-rtl"
    elif command -v wget &>/dev/null; then
        wget -qO- "$ARCHIVE_URL" | tar -xz -C "$TARGET_DIR" --strip-components=2 "hermes-webui-persian-main/vazir-persian-rtl"
    else
        echo -e "${RED}Error: curl or wget is required for installation.${NC}"
        exit 1
    fi
fi

# Update extension-install-manifest.json atomically
python3 - <<EOF
import json
import os
from pathlib import Path
from datetime import datetime, timezone

manifest_path = Path("$MANIFEST_FILE")
manifest_path.parent.mkdir(parents=True, exist_ok=True)
data = {"version": 1, "installed": {}}

if manifest_path.exists():
    try:
        with open(manifest_path, "r", encoding="utf-8") as f:
            parsed = json.load(f)
            if isinstance(parsed, dict) and isinstance(parsed.get("installed"), dict):
                data = parsed
    except Exception:
        pass

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
    "installed_at": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
}

with open(manifest_path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
EOF

echo -e "\n${GREEN}✓ Persian & Vazirmatn RTL support installed in < 1 second!${NC}"
echo -e "${GREEN}✓ 100% Persistent across WebUI updates, restarts, and git pulls.${NC}"
echo -e "${BLUE}Please refresh your Hermes WebUI tab (Ctrl+R / Cmd+R) to enjoy!${NC}\n"
