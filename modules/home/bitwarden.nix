{ config, lib, pkgs, secrets, ... }:

{
  options.bitwarden.enable = lib.mkEnableOption "Enable bitwarden";

  config = lib.mkIf config.bitwarden.enable {
    home.packages = with pkgs; [
      bitwarden-desktop
    ];
  };
}
