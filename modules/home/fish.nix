{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.fish;
in
{
  options.fish.enable = lib.mkEnableOption "Enable fish";

  config.programs.fish = lib.mkIf cfg.enable {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting "Welcome, $USER"
      ${lib.optionalString (config.starship.enable or false) ''
        starship init fish | source
        enable_transience
      ''}
    '';
    preferAbbrs = true;
  };
}
