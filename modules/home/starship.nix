{ config, lib, ... }:

let
  cfg = config.modules.home.starship;
in
{
  options.modules.home.starship.enable = lib.mkEnableOption "starship";

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        format = builtins.concatStringsSep "" [
          "$directory"
          "$fill"
          "$cmd_duration"
          "$git_branch$git_status"
          "$line_break"
          "$character"
        ];
        directory = {
          truncation_length = 5;
          truncation_symbol = "/.../";
          truncate_to_repo = false;
        };
        fill = {
          symbol = " ";
        };
        cmd_duration = {
          min_time = 3000;
        };
      };
    };
  };
}
