{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.unblob;
in
{
  options.unblob.enable = lib.mkEnableOption "Enable unblob";

  config.home.packages = lib.mkIf cfg.enable [
    (pkgs.unblob.overridePythonAttrs (old: {
      doCheck = false;
      doInstallCheck = false;
    }))
  ];
}
