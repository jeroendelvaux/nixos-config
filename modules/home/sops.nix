{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.sops;
in
{
  options.sops.enable = lib.mkEnableOption "Enable sops";

  config.sops = lib.mkIf cfg.enable {
    defaultSopsFile = let
      secrets-path = builtins.toString secrets;
    in "${secrets-path}/secrets.yaml";
    age = {
      keyFile = "${config.home.homeDirectory}/.config/age/keys.txt";
    };
    secrets = {
      rclone = {};
    };
  };

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    age
    sops
  ]);
}
