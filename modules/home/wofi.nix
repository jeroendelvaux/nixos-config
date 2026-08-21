{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.wofi;
in
{
  options.wofi.enable = lib.mkEnableOption "Enable wofi";

  config.programs.wofi = lib.mkIf cfg.enable {
    enable = true;
    settings = {
      location = "middle";
      show = "dmenu";
      allow_images = true;
      image_size = 30;
    };
    style = ''
      window{
        background-color: #292929;
        font-family: monospace, "JetBrainsMono Nerd Font";
      }
      #entry {
        color: #757575;
        background-color: #292929;
        border-color: #292929;
      }
      #entry:selected {
        color: #ff00ff;
        background-color: #330033;
        border-color: #cc66ff;
      }
      #text:selected {
        color: #ff00ff;
      }
    '';
  };
}
