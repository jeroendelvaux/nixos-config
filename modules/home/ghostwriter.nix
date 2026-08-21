{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.ghostwriter;
in
{
  options.ghostwriter.enable = lib.mkEnableOption "Enable ghostwriter";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    kdePackages.ghostwriter
  ]);
}
