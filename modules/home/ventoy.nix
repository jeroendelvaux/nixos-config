{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.ventoy;
  ventoyPkgs = import pkgs.path {
    localSystem = pkgs.stdenv.hostPlatform;
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "ventoy-gtk3"
      ];
      permittedInsecurePackages = [
        "ventoy-gtk3-1.1.12"
      ];
    };
  };
in
{
  options.modules.home.ventoy.enable = lib.mkEnableOption "ventoy";

  config = lib.mkIf cfg.enable {
    home.packages = [
      ventoyPkgs.ventoy-full-gtk
    ];
  };
}
