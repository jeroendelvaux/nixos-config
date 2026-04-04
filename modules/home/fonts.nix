{ config, lib, pkgs, secrets, ... }:

{
  options.fonts.enable = lib.mkEnableOption "Enable fonts";

  config = lib.mkIf config.fonts.enable {
    home.packages = with pkgs; [
      inter                      # Most GUIs
      noto-fonts                 # Fallback for most languages
      noto-fonts-cjk-sans        # Chinese, Japanase, Korean
      noto-fonts-color-emoji     # Icons and emojis
      liberation_ttf             # Fallback for Java apps
      dejavu_fonts               # Fallback for X11 apps
      nerd-fonts.jetbrains-mono  # Terminal and code editor
      nerd-fonts.hack            # Alternative coding font
    ];
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Inter" "Noto Sans" ];
        serif = [ "Noto Serif" "Liberation Serif" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
    home.activation = {
      fontconfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${pkgs.fontconfig}/bin/fc-cache -f
      '';
    };
  };
}
