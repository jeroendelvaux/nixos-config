{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.okular;
in
{
  options.modules.home.okular.enable = lib.mkEnableOption "okular";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.kdePackages.okular
    ];
  };
}
