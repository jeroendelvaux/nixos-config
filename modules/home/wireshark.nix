{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.wireshark;
in
{
  options.wireshark.enable = lib.mkEnableOption "Enable wireshark";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    wireshark
  ]);
}
