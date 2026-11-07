{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.burpsuite;
  niriEnabled = config.modules.home.niri.enable or false;
  javaOpts = lib.concatStringsSep " " [
    "-Dsun.awt.disablegrab=true"
    "-Dawt.useSystemAAFontSettings=on"
    "-Dswing.aatext=true"
    "-Dsun.java2d.uiScale=1.5"
  ];
  burpPkg = pkgs.symlinkJoin {
    name = "burpsuite-wrapped";
    paths = [ pkgs.burpsuite ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/burpsuite \
        --add-flags "--user-config-file=${config.xdg.configHome}/burp/user-config.json" \
        ${lib.optionalString niriEnabled ''
          --set _JAVA_AWT_WM_NONREPARENTING "1" \
          --set _JAVA_OPTIONS "${javaOpts}"
        ''}
    '';
  };
in
{
  options.modules.home.burpsuite.enable = lib.mkEnableOption "Burp Suite";

  config = lib.mkIf cfg.enable {
    home.packages = [
      burpPkg
    ];
    xdg = {
      configFile."burp/user-config.json".text = builtins.toJSON {
        user_options = {
          display = {
            user_interface = {
              font_size = 16;
              look_and_feel = "Dark";
            };
          };
        };
      };
    };
  };
}

