{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.ghidra;
in
{
  options.ghidra.enable = lib.mkEnableOption "Enable ghidra";

  config.java.enable = lib.mkIf cfg.enable true;

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    ghidra
  ]);

  config.xdg.enable = lib.mkIf cfg.enable true;

  config.xdg.configFile = lib.mkIf cfg.enable {
    "./ghidra/${pkgs.ghidra.distroPrefix}/preferences".text = ''
      GhidraShowWhatsNew=false
      SHOW.HELP.NAVIGATION.AID=true
      SHOW_TIPS=false
      TIP_INDEX=0
      G_FILE_CHOOSER.ShowDotFiles=true
      USER_AGREEMENT=ACCEPT
      Theme=File\:${config.home.homeDirectory}/.config/ghidra/${pkgs.ghidra.distroPrefix}/themes/Catppuccin_Mocha.theme
    '';

    "./ghidra/${pkgs.ghidra.distroPrefix}/themes/Catppuccin_Mocha.theme".source = let
      repo = pkgs.fetchFromGitHub {
        "owner" = "catppuccin";
        "repo" = "ghidra";
        "rev" = "5d7438b88c36c6c51530f9f4c46eacb7cb145ca1";
        "hash" = "sha256-PuFMWgcUxI8O9FOGdKEDw1HlCcjJ7bUP1moSS0bF84o=";
      };
    in "${repo}/themes/catppuccin-mocha.theme";
  };

  # deprecated
  # wayland.windowManager.hyprland.settings.windowrulev2 = lib.mkIf (cfg.enable && (config.hyprland.enable or false)) [
  #   "tile, class:^ghidra-Ghidra$, title:^(Ghidra:|.*CodeBrowser).*$"
  # ];
}
