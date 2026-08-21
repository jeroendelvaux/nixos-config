{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.fonts;
in
{
  options.fonts.enable = lib.mkEnableOption "Enable fonts";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    inter                      # Most GUIs
    noto-fonts                 # Fallback for most languages
    noto-fonts-cjk-sans        # Chinese, Japanase, Korean
    noto-fonts-color-emoji     # Icons and emojis
    liberation_ttf             # Fallback for Java apps
    dejavu_fonts               # Fallback for X11 apps
    nerd-fonts.jetbrains-mono  # Terminal and code editor
    nerd-fonts.hack            # Alternative coding font
  ]);

  config.fonts.fontconfig = lib.mkIf cfg.enable {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Inter" "Noto Sans" ];
      serif = [ "Noto Serif" "Liberation Serif" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  config.home.activation = lib.mkIf cfg.enable {
    fontconfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.fontconfig}/bin/fc-cache -f
    '';
  };
}
