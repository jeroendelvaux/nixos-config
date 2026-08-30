{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.firefox;
in
{
  options.modules.firefox.enable = lib.mkEnableOption "Enable firefox";

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          isDefault = true;
          containersForce = true;
          search.force = true;
          settings = {
            "ui.systemUsesDarkTheme" = 1;
            "layout.css.prefers-color-scheme.content-override" = 0;
            "extensions.autoDisableScopes" = 0; 
            "widget.use-xdg-desktop-portal.file-picker" = 1;
            "browser.newtabpage.activity-stream.feeds.topsites" = false;
            "browser.newtabpage.activity-stream.section.topstories.guide" = false;
            "browser.ai.control.default" = "blocked";
          };
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            darkreader # Inverts bright colors.
            ublock-origin # Blocks malware sites, ads, trackers, etc.
          ];
        };
      };
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
      };
      #configPath = "${config.xdg.configHome}/mozilla/firefox";
    };
  };
}
