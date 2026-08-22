{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.file;
in
{
  options.modules.file.enable = lib.mkEnableOption "Enable file";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.file
    ];
  };
}
