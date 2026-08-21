{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.hyprland;
in
{
  options.hyprland.enable = lib.mkEnableOption "Enable hyprland";

  config.wayland.windowManager.hyprland = lib.mkIf cfg.enable {
    enable = true;
    configType = "hyprlang"; # TODO: migrate to lua
    settings = {
      "$mod" = "SUPER";
      exec-once = [
        "waybar"
      ];
      bind = [
        "$mod, R, exec, wofi --show drun"
        "$mod, D, exec, wofi --show drun"
        "$mod, SPACE, exec, wofi --show drun"
        "$mod, RETURN, exec, foot"
        "$mod, T, exec, foot"
        "$mod, Q, killactive"
        "$mod, L, exec, hyprlock"
        "$mod, M, exit"
        "$mod, F, exec, hyprctl dispatch fullscreen toggle"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod SHIFT, left, movewindoworgroup, l"
        "$mod SHIFT, right, movewindoworgroup, r"
        "$mod SHIFT, up, movewindoworgroup, u"
        "$mod SHIFT, down, movewindoworgroup, d"
        "$mod CTRL, left, resizeactive, -40 0"
        "$mod CTRL, right, resizeactive, 40 0"
        "$mod CTRL, down, resizeactive, 0 -40"
        "$mod CTRL, up, resizeactive, 0 40"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        ", XF86AudioMute, exec, amixer -q set Master toggle"
        ", XF86AudioLowerVolume, exec, amixer -q set Master 5%-"
        ", XF86AudioRaiseVolume, exec, amixer -q set Master 5%+"
        ", XF86MonBrightnessDown, exec,  brightnessctl s 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
        ", PRINT, exec, slurp | grim -g - ~/Pictures/$(date +'screenshot_%Y-%m-%d-%H%M%S.png')"
      ];
      xwayland = {
        # crisp instead of pixelated apps:
        force_zero_scaling = true;
      };
      general = {
        gaps_in = 5; # Inner gaps between tiled windows
        gaps_out = 10; # Outer gaps between windows and screen edges
        border_size = 2;
      };
      dwindle = {
        force_split = 2;
      };
    };
    extraConfig = ''
      ecosystem:no_donation_nag = 1
    '';
  };

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    alsa-utils # amixer and alsamixer for volume control
    brightnessctl # backlight control
    slurp # area selection for screenshots
    grim # saving screenshots
    easyeffects
  ]);
}
