{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.java;
in
{
  options.java.enable = lib.mkEnableOption "Enable Java fixes";

  config.home.sessionVariables = lib.mkIf cfg.enable (
    {
      _JAVA_OPTIONS = lib.concatStringsSep " " [
        "-Dawt.useSystemAAFontSettings=on" # Anti-Aliasing
        "-Dswing.aatext=true"
        "-Dsun.java2d.xrender=true"
        "-Dsun.java2d.uiScale=1.5"
      ];
    }
    // lib.optionalAttrs (config.hyprland.enable or false) {
      _JAVA_AWT_WM_NONREPARENTING = "1";
    }
  );
}
