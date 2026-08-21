{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.imv;
in
{
  options.imv.enable = lib.mkEnableOption "Enable imv";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    imv
  ]);
}
