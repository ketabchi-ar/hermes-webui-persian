#!/usr/bin/env python3
"""
Hermes WebUI Persian & RTL Support - Cross-Platform Python Installer
Works on macOS, Linux, and Windows.
"""

import os
import shutil
import json
from pathlib import Path
from datetime import datetime, timezone

def install():
    print("=" * 55)
    print("    Hermes WebUI Persian & RTL Installer 🇮🇷")
    print("=" * 55)

    base_dir = Path(__file__).resolve().parent
    source_dir = base_dir / "vazir-persian-rtl"

    if not source_dir.exists():
        print("Error: vazir-persian-rtl folder not found in current directory.")
        return 1

    state_dir_env = os.getenv("HERMES_WEBUI_STATE_DIR")
    if state_dir_env:
        state_dir = Path(state_dir_env).expanduser().resolve()
    else:
        state_dir = Path.home() / ".hermes" / "webui"

    target_dir = state_dir / "extensions" / "vazir-persian-rtl"
    manifest_file = state_dir / "extension-install-manifest.json"

    print(f"Installing into: {target_dir}")
    target_dir.mkdir(parents=True, exist_ok=True)

    # Copy files
    for item in source_dir.iterdir():
        dest = target_dir / item.name
        if item.is_dir():
            if dest.exists():
                shutil.rmtree(dest)
            shutil.copytree(item, dest)
        else:
            shutil.copy2(item, dest)

    # Update extension-install-manifest.json
    state_dir.mkdir(parents=True, exist_ok=True)
    manifest_data = {"version": 1, "installed": {}}
    if manifest_file.exists():
        try:
            with manifest_file.open("r", encoding="utf-8") as f:
                parsed = json.load(f)
                if isinstance(parsed, dict) and isinstance(parsed.get("installed"), dict):
                    manifest_data = parsed
        except Exception:
            pass

    manifest_data["installed"]["vazir-persian-rtl"] = {
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

    with manifest_file.open("w", encoding="utf-8") as f:
        json.dump(manifest_data, f, indent=2, ensure_ascii=False)

    print("\n✓ Persian & Vazirmatn RTL support installed successfully!")
    print("✓ Persistent across Hermes WebUI updates & restarts.")
    print("Simply refresh your Hermes WebUI tab to see the changes.\n")
    return 0

if __name__ == "__main__":
    raise SystemExit(install())
