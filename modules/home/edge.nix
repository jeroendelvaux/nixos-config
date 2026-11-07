{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.edge;
in
{
  options.modules.home.edge.enable = lib.mkEnableOption "Microsoft Edge";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.microsoft-edge
    ];
  };
}
