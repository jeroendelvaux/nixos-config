{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.unblob;
in
{
  options.modules.home.unblob.enable = lib.mkEnableOption "unblob";

  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.unblob.overridePythonAttrs (old: {
        doCheck = false;
        doInstallCheck = false;
      }))
    ];
  };
}
