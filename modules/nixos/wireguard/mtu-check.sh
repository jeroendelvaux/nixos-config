#!/usr/bin/env bash
set -euo pipefail

readonly HEADER_SIZE=28
TARGET="${1:-8.8.8.8}"

echo "Hotels and public Wi-Fi often enforce low MTUs"
echo "Testing common MTU sizes against $TARGET..."

common_mtus=(1500 1492 1480 1450 1420 1400 1380 1360 1340 1320 1300 1280)
max_net_mtu=1280

for mtu in "${common_mtus[@]}"; do
    # Calculate ICMP payload size (-s) from total MTU minus headers
    payload=$(( mtu - HEADER_SIZE ))
    
    echo -n "Testing MTU $mtu (payload $payload)... "
    # Quoted "do" prevents ShellCheck SC1010 error on reserved keywords
    if ping -c 1 -W 1 -M "do" -s "$payload" "$TARGET" >/dev/null 2>&1; then
        echo "SUCCESS"
        max_net_mtu=$mtu
        break # Found the highest working size; stop iterating
    else
        echo "FAILED"
    fi
done

# WireGuard encapsulation safety margin (~80 bytes)
wg_mtu=$(( max_net_mtu - 80 ))
if [ "$wg_mtu" -lt 1280 ]; then
    wg_mtu=1280
fi

echo ""
echo "----------------------------------------"
echo " Maximum Network MTU : $max_net_mtu"
echo " Recommended WG MTU  : $wg_mtu"
echo "----------------------------------------"

