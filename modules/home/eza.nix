{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.eza;
in
{
  options.modules.eza.enable = lib.mkEnableOption "Enable eza";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.eza
    ];
    programs.fish.shellAbbrs = lib.mkIf (config.fish.enable or false) {
      "ls" = "eza";
    };
  };
}
