{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.foot;
in
{
  options.modules.foot.enable = lib.mkEnableOption "Enable foot";

  config = lib.mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "foot";
          shell = lib.mkIf (config.modules.fish.enable or false) "${pkgs.fish}/bin/fish";
          font = "JetBrainsMono Nerd Font:size=14";
          selection-target = "clipboard";
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
          clipboard-copy = "Control+Shift+c"; # Control+c for SIGINT
          clipboard-paste = "Control+v Control+Shift+v";
          font-increase = "Control+KP_Add";
          font-decrease = "Control+KP_Subtract";
        };
      };
    };
  };
}
