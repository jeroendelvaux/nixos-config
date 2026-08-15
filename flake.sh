#!/usr/bin/env sh
set -eu

echo "Update flake?"
echo "1) yes"
echo "2) no"
while :; do
  printf "1/2? "
  read -r update
  case $update in
    1) nix flake update; break ;;
    2) break ;;
    *) ;;
  esac
done

echo "Select host:"
echo "1) tiger"
echo "2) puma"
echo "3) leopard"

f_tiger() {
  sudo nixos-rebuild switch --flake .#tiger
}

f_puma() {
  nixos-rebuild switch \
    --flake .#puma \
    --target-host puma \
    --sudo \
    --ask-sudo-password
}

f_leopard() {
  :
}

while :; do
  printf "1/2/3? "
  read -r host
  case $host in
    1) f_tiger; break ;;
    2) f_puma; break ;;
    3) f_leopard; break ;;
    *) ;;
  esac
done
