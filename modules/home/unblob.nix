{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.unblob;
in
{
  options.modules.unblob.enable = lib.mkEnableOption "Enable unblob";

  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.unblob.overridePythonAttrs (old: {
        doCheck = false;
        doInstallCheck = false;
      }))
    ];
  };
}
