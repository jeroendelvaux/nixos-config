{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.nh;
in
{
  options.nh.enable = lib.mkEnableOption "Enable nh";

  config.programs.nh = lib.mkIf cfg.enable {
    enable = true;
    # Automatic garbage collection policy:
    # - Keep all generations from the past week.
    # - Additionally, keep 3 generations older than one week.
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };
  };
}
