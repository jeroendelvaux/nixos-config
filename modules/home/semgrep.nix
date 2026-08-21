{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.semgrep;
in
{
  options.semgrep.enable = lib.mkEnableOption "Enable semgrep";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    semgrep
  ]);

  config.home.sessionVariables = lib.mkIf cfg.enable {
    SEMGREP_SEND_METRICS = "off";
  };
}
