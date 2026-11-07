{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.gtk;
in
{
  options.modules.home.gtk.enable = lib.mkEnableOption "GTK";

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
      XDG_DATA_DIRS = lib.concatStringsSep ":" [
        "$HOME/.nix-profile/share"
        "/etc/profiles/per-user/$USER/share"
        "/run/current-system/sw/share"
      ];
    };
  };
}
