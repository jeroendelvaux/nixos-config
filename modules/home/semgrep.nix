{ config, lib, pkgs, secrets, ... }:

{
  options.semgrep.enable = lib.mkEnableOption "Enable semgrep";

  config = lib.mkIf config.semgrep.enable {
    home.packages = with pkgs; [
      semgrep
    ];
    home.sessionVariables = {
      SEMGREP_SEND_METRICS = "off";
    };
  };
}
