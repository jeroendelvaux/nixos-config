{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.semgrep;
in
{
  options.modules.home.semgrep.enable = lib.mkEnableOption "semgrep";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.semgrep
    ];
    home.sessionVariables = {
      SEMGREP_SEND_METRICS = "off";
    };
  };
}
