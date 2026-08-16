#!/usr/bin/env sh
sudo apt install -y curl
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
export NIX_CONFIG="experimental-features = nix-command flakes"
nix run home-manager/release-25.11 -- switch --flake .