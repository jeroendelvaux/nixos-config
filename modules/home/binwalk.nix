{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.binwalk;
in
{
  options.binwalk.enable = lib.mkEnableOption "Enable binwalk";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    binwalk
  ]);
}
