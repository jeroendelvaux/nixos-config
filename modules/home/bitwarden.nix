{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.bitwarden;
in
{
  options.bitwarden.enable = lib.mkEnableOption "Enable bitwarden";

  # nixpkgs.config.permittedInsecurePackages = [
  #   "electron-39.8.10"
  # ];

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    bitwarden-desktop
  ]);
}
