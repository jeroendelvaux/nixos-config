{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.btop;
in
{
  options.btop.enable = lib.mkEnableOption "Enable btop";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    btop
  ]);
}
