{ config, lib, pkgs, secrets, ... }:

{
  options.sops.enable = lib.mkEnableOption "Enable sops";

  config = lib.mkIf config.sops.enable {
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
    home.packages = with pkgs; [
      age
      sops
    ];
  };
}
