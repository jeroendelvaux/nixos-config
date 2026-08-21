{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.bat;
in
{
  options.bat.enable = lib.mkEnableOption "Enable bat";

  config.programs.bat = lib.mkIf cfg.enable {
    enable = true;
    config = {
      pager = "";
      theme = "CatppuccinMocha";
    };
  };

  config.xdg = lib.mkIf cfg.enable {
    enable = true;
    configFile."./bat/themes/CatppuccinMocha.tmTheme" = {
      source = let
        repo = pkgs.fetchFromGitHub {
          "owner" = "catppuccin";
          "repo" = "bat";
          "rev" = "6810349b28055dce54076712fc05fc68da4b8ec0";
          "hash" = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
        };
      in "${repo}/themes/Catppuccin Mocha.tmTheme";
    };
  };

  config.programs.fish.shellAbbrs = lib.mkIf (cfg.enable && (config.fish.enable or false)) {
    "cat" = "bat";
  };
}
