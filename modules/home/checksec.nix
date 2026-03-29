{ config, lib, pkgs, secrets, ... }:

{
  options.checksec.enable = lib.mkEnableOption "Enable checksec";

  config = lib.mkIf config.checksec.enable {
    home.packages = with pkgs; [
      checksec
    ];
  };
}
