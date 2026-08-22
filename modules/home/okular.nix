{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.okular;
in
{
  options.modules.okular.enable = lib.mkEnableOption "Enable okular";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.kdePackages.okular
    ];
  };
}
