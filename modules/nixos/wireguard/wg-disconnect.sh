#!/usr/bin/env bash
set -euo pipefail

exec systemctl stop wg-quick-wg0.service --no-block

