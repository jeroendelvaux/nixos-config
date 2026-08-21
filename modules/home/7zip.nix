{ config, lib, pkgs, secrets, ... }:

let
  cfg = config."7zip";
in
{
  options."7zip".enable = lib.mkEnableOption "Enable 7zip";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    _7zz
  ]);

  config.programs.fish.shellAbbrs = lib.mkIf (cfg.enable && (config.fish.enable or false)) {
    "7z" = "7zz";
  };
}
