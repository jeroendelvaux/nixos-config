{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.ghostwriter;
in
{
  options.modules.ghostwriter.enable = lib.mkEnableOption "Enable ghostwriter";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.kdePackages.ghostwriter
    ];
  };
}
