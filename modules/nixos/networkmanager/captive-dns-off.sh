#!/usr/bin/env bash
set -e

echo "Restoring secure global DNS..."
sudo rm -f /etc/systemd/resolved.conf.d/disable-global.conf
sudo systemctl restart systemd-resolved
echo "Global DNS restored."

