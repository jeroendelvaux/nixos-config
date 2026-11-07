{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.jadx;
  niriEnabled = config.modules.home.niri.enable or false;
  javaOpts = lib.concatStringsSep " " [
    "-Dsun.awt.disablegrab=true"
    "-Dawt.useSystemAAFontSettings=on"
    "-Dswing.aatext=true"
    "-Dsun.java2d.uiScale=1.5"
  ];
  jadxPkg = if niriEnabled then pkgs.symlinkJoin {
    name = "jadx-wrapped";
    paths = [ pkgs.jadx ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/jadx-gui \
        --set _JAVA_AWT_WM_NONREPARENTING "1" \
        --set _JAVA_OPTIONS "${javaOpts}"
    '';
  } else pkgs.jadx;
in
{
  options.modules.home.jadx.enable = lib.mkEnableOption "JADX";

  config = lib.mkIf cfg.enable {
    home.packages = [
      jadxPkg
    ];
    xdg.configFile."jadx/gui.json".text = builtins.toJSON {
      "editorThemePath" = "/org/fife/ui/rsyntaxtextarea/themes/monokai.xml";
      "lafTheme" = "Monocai";
    };
  };
}
