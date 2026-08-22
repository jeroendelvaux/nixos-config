{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.hyprpaper;
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/x6/wallhaven-x6vjkz.png";
    sha256 = "sha256-zfNhHnnuzi20wssJ2DAzLz+o+dZYgeiKJmuXvZtlrhA=";
  };
in
{
  options.modules.hyprpaper.enable = lib.mkEnableOption "Enable hyprpaper";

  config = lib.mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        preload = [ "${wallpaper}" ];
        wallpaper = [
          { monitor = ""; path = "${wallpaper}"; }
        ];
      };
    };
  };
}
