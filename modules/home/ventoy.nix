{ config, lib, pkgs, secrets, ... }:

{
  options.ventoy.enable = lib.mkEnableOption "Enable ventoy";

  config = lib.mkIf config.ventoy.enable {
    home.packages = with pkgs; [ ventoy-full-gtk ];
    #nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [ "ventoy-gtk3" ];
    #nixpkgs.config.permittedInsecurePackages = [ "ventoy-gtk3-1.1.05" ];
  };
}
