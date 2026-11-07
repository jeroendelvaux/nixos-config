{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.wget;
in
{
  options.modules.home.wget.enable = lib.mkEnableOption "wget";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.wget
    ];
    programs.fish.shellAbbrs = lib.mkIf (config.modules.home.fish.enable or false) {
      "wget" = "wget -c";
    };
  };
}
