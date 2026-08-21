{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.file;
in
{
  options.file.enable = lib.mkEnableOption "Enable file";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    file
  ]);
}
