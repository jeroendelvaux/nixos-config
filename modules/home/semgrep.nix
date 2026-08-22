{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.semgrep;
in
{
  options.modules.semgrep.enable = lib.mkEnableOption "Enable semgrep";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.semgrep
    ];
    home.sessionVariables = {
      SEMGREP_SEND_METRICS = "off";
    };
  };
}
