{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.picocom;
in
{
  options.modules.picocom.enable = lib.mkEnableOption "Enable picocom";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.picocom
    ];
  };
}
