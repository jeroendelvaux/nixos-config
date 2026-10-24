#!/usr/bin/env bash
set -euo pipefail

exec systemctl start wg-quick-wg0.service

