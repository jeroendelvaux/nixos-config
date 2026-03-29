{ config, lib, pkgs, pkgs-unstable, secrets, ... }:

{
  sops = {
    defaultSopsFile = let
       secrets-path = builtins.toString secrets;
    in "${secrets-path}/secrets.yaml";

    age = {
      keyFile = "/home/${secrets.user.name}/.config/age/keys.txt";
    };
    secrets = {
      openvpn = {};
    };
  };
}