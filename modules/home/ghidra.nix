{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.ghidra;
  niriEnabled = config.modules.home.niri.enable or false;
  javaOpts = lib.concatStringsSep " " [
    "-Dsun.awt.disablegrab=true"
    "-Dawt.useSystemAAFontSettings=on"
    "-Dswing.aatext=true"
    "-Dsun.java2d.uiScale=1.5"
  ];
  ghidraPkg = if niriEnabled then pkgs.symlinkJoin {
    name = "ghidra-wrapped";
    paths = [ pkgs.ghidra ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/ghidra \
        --set _JAVA_AWT_WM_NONREPARENTING "1" \
        --set _JAVA_OPTIONS "${javaOpts}"
    '';
  } else pkgs.ghidra;
in
{
  options.modules.home.ghidra.enable = lib.mkEnableOption "Ghidra";

  config = lib.mkIf cfg.enable {
    home.packages = [
      ghidraPkg
    ];
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
            owner = "catppuccin";
            repo = "ghidra";
            rev = "5d7438b88c36c6c51530f9f4c46eacb7cb145ca1";
            hash = "sha256-PuFMWgcUxI8O9FOGdKEDw1HlCcjJ7bUP1moSS0bF84o=";
          };
        in "${repo}/themes/catppuccin-mocha.theme";
      };
    };
  };
}

