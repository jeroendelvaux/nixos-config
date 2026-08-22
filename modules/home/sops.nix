{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.sops;
in
{
  options.modules.sops.enable = lib.mkEnableOption "Enable sops";

  config = lib.mkIf cfg.enable {
    sops = {
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
    home.packages = [
      pkgs.age
      pkgs.sops
    ];
  };
}
