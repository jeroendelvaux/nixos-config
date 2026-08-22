{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.bat;
in
{
  options.modules.bat.enable = lib.mkEnableOption "Enable bat";

  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config = {
        pager = "";
        theme = "CatppuccinMocha";
      };
    };
    xdg = {
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
    programs.fish.shellAbbrs = lib.mkIf (config.fish.enable or false) {
      "cat" = "bat";
    };
  };
}
