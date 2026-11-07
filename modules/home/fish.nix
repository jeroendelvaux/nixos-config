{ config, lib, ... }:

let
  cfg = config.modules.home.fish;
in
{
  options.modules.home.fish.enable = lib.mkEnableOption "fish";

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
