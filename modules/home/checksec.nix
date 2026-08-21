{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.checksec;
in
{
  options.checksec.enable = lib.mkEnableOption "Enable checksec";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    checksec
  ]);
}
