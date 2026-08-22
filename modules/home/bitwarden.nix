{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.bitwarden;
in
{
  options.modules.bitwarden.enable = lib.mkEnableOption "Enable bitwarden";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.bitwarden-desktop
    ];
  };
}
