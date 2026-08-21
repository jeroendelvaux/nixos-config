{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.ascii;
in
{
  options.ascii.enable = lib.mkEnableOption "Enable ascii";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    ascii
  ]);
}
