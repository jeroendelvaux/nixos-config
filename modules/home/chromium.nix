{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.chromium;
in
{
  options.modules.home.chromium.enable = lib.mkEnableOption "Chromium";

  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.chromium;
      commandLineArgs = [ "--ozone-platform-hint=auto" ];
    };
  };
}
