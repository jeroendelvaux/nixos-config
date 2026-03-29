{ config, lib, pkgs, secrets, ... }:

{
  options.kitty.enable = lib.mkEnableOption "Enable kitty";

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      extraConfig = lib.optionalString (
        config.fish.enable or false
      ) ''
        shell fish
      '';
      settings = {
        confirm_os_window_close = 0;
      };
      font = {
        name = lib.optionalString (
          config.nerdfonts.enable or false
        ) "JetBrainsMono Nerd Font";
        size = 14;
      };
      keybindings = {
        "ctrl+c" = "copy_or_interrupt";
        "ctrl+v" = "paste_from_clipboard";
        "ctrl+kp_add" = "change_font_size all +0.5";
        "ctrl+kp_subtract" = "change_font_size all -0.5";
      };
      themeFile = "Catppuccin-Mocha";
    };
  };
}
