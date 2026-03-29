{ config, lib, pkgs, secrets, ... }:

{
  options.ghidra.enable = lib.mkEnableOption "Enable ghidra";

  config = lib.mkIf config.ghidra.enable (lib.mkMerge [{
    home = {
      packages = with pkgs; [ ghidra ];
      sessionVariables = {
        _JAVA_AWT_WM_NONREPARENTING = 1; # Compatibility with window managers.
      };
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
          Theme=File\:/home/${secrets.user.name}/.config/ghidra/${pkgs.ghidra.distroPrefix}/themes/Catppuccin_Mocha.theme
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
  (lib.mkIf (config.hyprland.enable or false) {
    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "tile, class:^ghidra-Ghidra$, title:^(Ghidra:|.*CodeBrowser).*$"
    ];
  })]);
}
