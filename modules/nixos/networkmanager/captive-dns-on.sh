#!/usr/bin/env bash
set -e

INTERFACE="${1:-wlp56s0}"

echo "Switching to local Wi-Fi provider DNS for captive portal..."
DNS_SERVERS=$(nmcli -g IP4.DNS device show "$INTERFACE" | tr '|' ' ')

if [ -z "$DNS_SERVERS" ]; then
  echo "Error: No DHCP DNS servers found on interface $INTERFACE."
  exit 1
fi

echo "Found local DNS: $DNS_SERVERS"

# Temporarily disable global DNS via a drop-in and restart systemd-resolved
sudo mkdir -p /etc/systemd/resolved.conf.d
echo -e "[Resolve]\nDNS=" | sudo tee /etc/systemd/resolved.conf.d/disable-global.conf > /dev/null
sudo systemctl restart systemd-resolved

# Apply local DHCP DNS to the interface
sudo resolvectl dns "$INTERFACE" $DNS_SERVERS
sudo resolvectl default-route "$INTERFACE" true

echo "Done. Captive portal DNS active."
