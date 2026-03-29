{ config, lib, pkgs, secrets, ... }:

{
  options.ghostwriter.enable = lib.mkEnableOption "Enable ghostwriter";

  config = lib.mkIf config.ghostwriter.enable {
    home.packages = with pkgs; [
      kdePackages.ghostwriter
    ];
  };
}
