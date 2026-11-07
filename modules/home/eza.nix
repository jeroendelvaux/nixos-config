{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.eza;
in
{
  options.modules.home.eza.enable = lib.mkEnableOption "eza";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.eza
    ];
    programs.fish.shellAbbrs = lib.mkIf (config.modules.home.fish.enable or false) {
      "ls" = "eza";
    };
  };
}
