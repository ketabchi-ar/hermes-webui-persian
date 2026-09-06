---
name: hermes-persian
description: "Install, manage, toggle, and troubleshoot Persian RTL and Vazirmatn font support for Hermes WebUI."
version: 1.0.0
author: Rick Sanchez & Community
license: MIT
metadata:
  hermes:
    tags: [persian, rtl, vazirmatn, webui, extension, typography]
---

# Hermes WebUI Persian & RTL Skill

This skill allows Hermes Agent to autonomously install, verify, and manage the Persian RTL & Vazirmatn font extension on Hermes WebUI.

## Quick Install Procedure

To install or repair the Persian RTL extension:

```bash
curl -fsSL https://raw.githubusercontent.com/m4tinbeigi-official/hermes-webui-persian/main/install.sh | bash
```

## Verification

Check if the extension is registered:

```python
from api.extensions import get_extension_config, get_extension_status
print(get_extension_config())
```

## Uninstallation

To remove the extension:

```bash
curl -fsSL https://raw.githubusercontent.com/m4tinbeigi-official/hermes-webui-persian/main/uninstall.sh | bash
```
