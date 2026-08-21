{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.android-tools;
in
{
  options.android-tools.enable = lib.mkEnableOption "Enable android-tools";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    android-tools
    apksigner
  ]);
}
