{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.ghostwriter;
in
{
  options.modules.home.ghostwriter.enable = lib.mkEnableOption "Ghostwriter";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.kdePackages.ghostwriter
    ];
  };
}
