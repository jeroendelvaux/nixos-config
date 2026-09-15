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
        captive = {
          isDefault = false;
          id = 1;
          settings = {
            # Detect captive portals:
            "network.captive-portal-service.enabled" = true;
            # Disable built-in DNS-over-HTTPS (DoH):
            "network.trr.mode" = 5;
            # Do not upgrade HTTP to HTTPS:
            "dom.security.https_only_mode" = false;
            # Do not restore the previous session after a crash:
            "browser.sessionstore.resume_from_crash" = false;
            # Discard history, cookies, and cached pages when closing Firefox:
            "browser.privatebrowsing.autostart" = true;
            # HTTP-only start page:
            "browser.startup.page" = 1;
            "browser.startup.homepage" = "http://neverssl.com";
          };
        };
      };
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
      };
    };
  };
}
