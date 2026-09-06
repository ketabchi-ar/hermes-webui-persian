#!/usr/bin/env bash
# Hermes WebUI Persian & RTL Support - Uninstaller

set -e

STATE_DIR="${HERMES_WEBUI_STATE_DIR:-$HOME/.hermes/webui}"
TARGET_DIR="$STATE_DIR/extensions/vazir-persian-rtl"
MANIFEST_FILE="$STATE_DIR/extension-install-manifest.json"

echo "Uninstalling Hermes WebUI Persian RTL extension..."

rm -rf "$TARGET_DIR"

if [ -f "$MANIFEST_FILE" ]; then
    python3 - <<EOF
import json
from pathlib import Path

manifest_path = Path("$MANIFEST_FILE")
if manifest_path.exists():
    try:
        with open(manifest_path, "r", encoding="utf-8") as f:
            data = json.load(f)
        if isinstance(data, dict) and "installed" in data and isinstance(data["installed"], dict):
            data["installed"].pop("vazir-persian-rtl", None)
            with open(manifest_path, "w", encoding="utf-8") as f:
                json.dump(data, f, indent=2, ensure_ascii=False)
    except Exception:
        pass
EOF
fi

echo "✓ Persian RTL extension uninstalled. Refresh your WebUI tab."
