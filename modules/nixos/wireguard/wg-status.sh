#!/usr/bin/env bash
set -euo pipefail

if systemctl is-active --quiet wg-quick-wg0.service; then
  echo "connected"
else
  echo "disconnected"
fi

