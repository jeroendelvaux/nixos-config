{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.ventoy;
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
  options.modules.ventoy.enable = lib.mkEnableOption "Enable ventoy";

  config = lib.mkIf cfg.enable {
    home.packages = [
      ventoyPkgs.ventoy-full-gtk
    ];
  };
}
