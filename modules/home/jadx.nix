{ config, lib, pkgs, secrets, ... }:

{
  options.jadx.enable = lib.mkEnableOption "Enable JADX";

  config = lib.mkIf config.jadx.enable {
    java.enable = true;
    home.packages = with pkgs; [
      jadx
    ];
    xdg.configFile."jadx/gui.json".text = builtins.toJSON {
      "editorThemePath" = "/org/fife/ui/rsyntaxtextarea/themes/monokai.xml";
      "lafTheme" = "Monocai";
    };
  };
}
