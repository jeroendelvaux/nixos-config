{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.rizin;
in
{
  options.rizin.enable = lib.mkEnableOption "Enable rizin";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    rizin
  ]);
}
