{ config, lib, pkgs, secrets, ... }:

{
  options.foot.enable = lib.mkEnableOption "Enable foot";

  config = lib.mkIf config.foot.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "foot";
          shell = lib.mkIf (config.fish.enable or false) "${pkgs.fish}/bin/fish";
          font = "JetBrainsMono Nerd Font:size=14";
          include = let
            themeRepo = pkgs.fetchFromGitHub {
              owner = "catppuccin";
              repo = "foot";
              rev = "99384a83ee9246cd0a38aeee07d8300367724602";
              hash = "sha256-lFa5EpoLkrZcC80YDHyVOTnwYOCNybznlD80NkgVLYs=";
            };
          in "${themeRepo}/themes/catppuccin-mocha.ini";
        };
        key-bindings = {
          clipboard-copy = "Control+c";
          clipboard-paste = "Control+v";
          font-increase = "Control+KP_Add";
          font-decrease = "Control+KP_Subtract";
        };
      };
    };
  };
}
