{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.eza;
in
{
  options.eza.enable = lib.mkEnableOption "Enable eza";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    eza
  ]);

  config.programs.fish.shellAbbrs = lib.mkIf (cfg.enable && (config.fish.enable or false)) {
    "ls" = "eza";
  };
}
