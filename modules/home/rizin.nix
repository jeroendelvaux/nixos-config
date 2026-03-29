{ config, lib, pkgs, secrets, ... }:

{
  options.rizin.enable = lib.mkEnableOption "Enable rizin";

  config = lib.mkIf config.rizin.enable {
    home.packages = with pkgs; [
      rizin
    ];
  };
}
