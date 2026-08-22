{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.android-tools;
in
{
  options.modules.android-tools.enable = lib.mkEnableOption "Enable android-tools";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.android-tools
      pkgs.apksigner
    ];
  };
}
