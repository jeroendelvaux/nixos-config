{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.gtk;
in
{
  options.modules.gtk.enable = lib.mkEnableOption "Enable gtk";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.adwaita-icon-theme
    ];

    gtk = {
      enable = true;
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    };

    home.sessionVariables = {
      XDG_DATA_DIRS = "$HOME/.nix-profile/share:/etc/profiles/per-user/$USER/share:/run/current-system/sw/share";
    };
  };
}
