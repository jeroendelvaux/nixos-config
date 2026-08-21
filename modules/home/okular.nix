{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.okular;
in
{
  options.okular.enable = lib.mkEnableOption "Enable okular";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    kdePackages.okular 
  ]);
}
