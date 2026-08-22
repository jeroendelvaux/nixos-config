{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.fish;
in
{
  options.modules.fish.enable = lib.mkEnableOption "Enable fish";

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting "Welcome, $USER"
        ${lib.optionalString (config.modules.starship.enable or false) ''
          starship init fish | source
          enable_transience
        ''}
      '';
      preferAbbrs = true;
    };
  };
}
