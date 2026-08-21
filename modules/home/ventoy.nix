{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.ventoy;
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
  options.ventoy.enable = lib.mkEnableOption "Enable ventoy";

  config.home.packages = lib.mkIf cfg.enable [
    ventoyPkgs.ventoy-full-gtk
  ];
}
