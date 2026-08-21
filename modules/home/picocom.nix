{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.picocom;
in
{
  options.picocom.enable = lib.mkEnableOption "Enable picocom";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    picocom
  ]);
}
