{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.hexedit;
in
{
  options.hexedit.enable = lib.mkEnableOption "Enable hexedit";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    hexedit
  ]);
}
