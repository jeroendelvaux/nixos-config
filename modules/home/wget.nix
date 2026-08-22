{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.wget;
in
{
  options.modules.wget.enable = lib.mkEnableOption "Enable wget";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.wget
    ];
    programs.fish.shellAbbrs = lib.mkIf (config.fish.enable or false) {
      "wget" = "wget -c";
    };
  };
}
