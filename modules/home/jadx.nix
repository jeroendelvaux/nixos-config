{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.jadx;
in
{
  options.modules.jadx.enable = lib.mkEnableOption "Enable JADX";

  config = lib.mkIf cfg.enable {
    modules.java.enable = true;
    home.packages = [
      pkgs.jadx
    ];
    xdg.configFile."jadx/gui.json".text = builtins.toJSON {
      "editorThemePath" = "/org/fife/ui/rsyntaxtextarea/themes/monokai.xml";
      "lafTheme" = "Monocai";
    };
  };
}
