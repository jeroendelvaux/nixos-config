{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.bitwarden;
in
{
  options.modules.home.bitwarden.enable = lib.mkEnableOption "Bitwarden";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.bitwarden-desktop
    ];
  };
}
