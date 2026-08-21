{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.jadx;
in
{
  options.jadx.enable = lib.mkEnableOption "Enable JADX";

  config.java.enable = lib.mkIf cfg.enable true;

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    jadx
  ]);

  config.xdg.configFile."jadx/gui.json" = lib.mkIf cfg.enable {
    text = builtins.toJSON {
      "editorThemePath" = "/org/fife/ui/rsyntaxtextarea/themes/monokai.xml";
      "lafTheme" = "Monocai";
    };
  };
}
