{ config, lib, pkgs, secrets, ... }:

{
  options.bitwarden.enable = lib.mkEnableOption "Enable bitwarden";

  config = lib.mkIf config.bitwarden.enable {
     nixpkgs.config.permittedInsecurePackages = [
       "electron-39.8.10"
     ];
     home.packages = with pkgs; [
      bitwarden-desktop
    ];
  };
}
