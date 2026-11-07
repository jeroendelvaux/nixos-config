{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.file;
in
{
  options.modules.home.file.enable = lib.mkEnableOption "file";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.file
    ];
  };
}
