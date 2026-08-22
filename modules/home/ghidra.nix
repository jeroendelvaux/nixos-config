{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.ghidra;
in
{
  options.modules.ghidra.enable = lib.mkEnableOption "Enable ghidra";

  config = lib.mkIf cfg.enable (lib.mkMerge [{
    modules.java.enable = true;
    home = {
      packages = with pkgs; [ ghidra ];
    };
    xdg = {
      enable = true;
      configFile."./ghidra/${pkgs.ghidra.distroPrefix}/preferences" = {
        text = ''
          GhidraShowWhatsNew=false
          SHOW.HELP.NAVIGATION.AID=true
          SHOW_TIPS=false
          TIP_INDEX=0
          G_FILE_CHOOSER.ShowDotFiles=true
          USER_AGREEMENT=ACCEPT
          Theme=File\:${config.home.homeDirectory}/.config/ghidra/${pkgs.ghidra.distroPrefix}/themes/Catppuccin_Mocha.theme
        '';
      };
      configFile."./ghidra/${pkgs.ghidra.distroPrefix}/themes/Catppuccin_Mocha.theme" = {
        source = let
          repo = pkgs.fetchFromGitHub {
            "owner" = "catppuccin";
            "repo" = "ghidra";
            "rev" = "5d7438b88c36c6c51530f9f4c46eacb7cb145ca1";
            "hash" = "sha256-PuFMWgcUxI8O9FOGdKEDw1HlCcjJ7bUP1moSS0bF84o=";
          };
        in "${repo}/themes/catppuccin-mocha.theme";
      };
    };
  }
  (lib.mkIf (config.modules.hyprland.enable or false) {
   # deprecated
   # wayland.windowManager.hyprland.settings.windowrulev2 = [
   #   "tile, class:^ghidra-Ghidra$, title:^(Ghidra:|.*CodeBrowser).*$"
   # ];
  })]);
}
