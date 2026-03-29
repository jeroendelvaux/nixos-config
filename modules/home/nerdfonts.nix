{ config, lib, pkgs, secrets, ... }:

{
  options.nerdfonts.enable = lib.mkEnableOption "Enable nerdfonts";

  config = lib.mkIf config.nerdfonts.enable {
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.hack
    ];
    home.activation = {
      fontconfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${pkgs.fontconfig}/bin/fc-cache -f
      '';
    };
  };
}
