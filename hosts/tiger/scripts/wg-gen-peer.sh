#!/usr/bin/env bash
set -euo pipefail

read -rp "Enter peer name (e.g., phone): " PEER_NAME
read -rp "Enter last octet of IP (e.g., 3 for 10.100.0.3): " OCTET

CLIENT_IP="10.100.0.${OCTET}/32"
CONF_FILE="${PEER_NAME}-wg0.conf"

PRIVKEY=$(wg genkey)
PUBKEY=$(echo "${PRIVKEY}" | wg pubkey)

cat <<EOF > "${CONF_FILE}"
[Interface]
PrivateKey = ${PRIVKEY}
Address = ${CLIENT_IP}
DNS = 1.1.1.1

[Peer]
PublicKey = ${SERVER_PUBKEY}
Endpoint = ${SERVER_ENDPOINT}
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25
EOF

echo ""
echo "=== NixOS Peer Block ==="
echo "{"
echo "  # ${PEER_NAME}"
echo "  publicKey = \"${PUBKEY}\";"
echo "  allowedIPs = [ \"${CLIENT_IP}\" ];"
echo "}"
echo ""
echo "=== QR Code for ${PEER_NAME} ==="
qrencode -t ansiutf8 < "${CONF_FILE}"
echo ""
echo "Saved config to ${CONF_FILE}"
