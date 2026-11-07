{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home."7zip";
in
{
  options.modules.home."7zip".enable = lib.mkEnableOption "7-Zip";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs._7zz
    ];
    programs.fish.shellAbbrs = lib.mkIf (config.modules.home.fish.enable or false) {
      "7z" = "7zz";
    };
  };
}
