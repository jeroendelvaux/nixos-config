{ config, lib, pkgs, secrets, ... }:

{
  options.imv.enable = lib.mkEnableOption "Enable imv";

  config = lib.mkIf config.imv.enable {
    home.packages = with pkgs; [
      imv
    ];
  };
}
