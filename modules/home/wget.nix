{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.wget;
in
{
  options.wget.enable = lib.mkEnableOption "Enable wget";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    wget
  ]);

  config.programs.fish.shellAbbrs = lib.mkIf (cfg.enable && (config.fish.enable or false)) {
    "wget" = "wget -c";
  };
}
