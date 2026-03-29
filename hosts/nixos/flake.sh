#!/usr/bin/env sh
set -eu
echo "Starting point?"
echo "1. Update flake"
echo "2. Rebuild NixOS"
echo "3. Rebuild Home"
f1() {
    nix flake update
}
f2() {
    #sudo nixos-rebuild boot --flake .
    #reboot
    sudo nixos-rebuild switch --flake .
}
f3() {
    home-manager switch --flake .#default
}
while :
do
    read -p "1/2/3? " nb
    case $nb in
        1 ) f1; f2; f3; break;;
        2 ) f2; f3; break;;
        3 ) f3; break;;
        * ) ;;
    esac
done
