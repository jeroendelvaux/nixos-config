{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules."7zip";
in
{
  options.modules."7zip".enable = lib.mkEnableOption "Enable 7zip";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs._7zz
    ];
    programs.fish.shellAbbrs = lib.mkIf (config.modules.fish.enable or false) {
      "7z" = "7zz";
    };
  };
}
